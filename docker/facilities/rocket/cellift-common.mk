# Copyright 2022 Flavien Solt, ETH Zurich.
# Licensed under the General Public License, Version 3.0, see LICENSE for details.
# SPDX-License-Identifier: GPL-3.0-only

ifeq "" "$(CELLIFT_ENV_SOURCED)"
$(error Please re-source env.sh first, in the meta repo, and run from there, not this repo. See README.md in the meta repo)
endif

PYTHON ?= python3

TOP_EXECUTABLE_NAME = Vtop_tiny_soc

# The `passthrough` target is useful so that the log matches with the sv on the generated block names, typically for ideal taint experiments.
TARGET_NAMES = vanilla cellift glift passthrough

# Path to the design verilog

DESIGN_VERILOG_ROOT = ../sims/verilator/generated-src/chipyard.TestHarness.$(DESIGN_CONFIG)/chipyard.TestHarness.$(DESIGN_CONFIG).top
PATH_TO_DESIGN_MEMS_VERILOG = $(DESIGN_VERILOG_ROOT).mems.v
PATH_TO_DESIGN_VERILOG = $(DESIGN_VERILOG_ROOT).v
PATH_TO_DESIGN_VERILOG_REPLACED_BOOTROM = generated/replaced_bootrom.sv

DESIGN_VERILOG_DEPENDENCIES=$(patsubst %,src/dependencies/%, ClockDividerN.sv EICG_wrapper.v IOCell.v plusarg_reader.v sram_behav_models.v)

ifeq ($(REPLACE_BOOTROM),0)
DESIGN_SOURCES_TO_INSTRUMENT = $(DESIGN_VERILOG_DEPENDENCIES) $(PATH_TO_DESIGN_MEMS_VERILOG) $(PATH_TO_DESIGN_VERILOG) generated/$(DESIGN_NAME)_axi_to_mem.v generated/$(DESIGN_NAME)_mem_top.v
else
DESIGN_SOURCES_TO_INSTRUMENT = $(DESIGN_VERILOG_DEPENDENCIES) $(PATH_TO_DESIGN_MEMS_VERILOG) $(PATH_TO_DESIGN_VERILOG_REPLACED_BOOTROM) generated/$(DESIGN_NAME)_axi_to_mem.v generated/$(DESIGN_NAME)_mem_top.v
endif

include $(CELLIFT_DESIGN_PROCESSING_ROOT)/common/design.mk

# This target makes the design until the Yosys instrumentation. From there on, the Makefile can run in parallel for the various instrumentation targets.
before_instrumentation: generated/out/vanilla.sv

#
# 0. Generate the design sources sources
#

#$(PATH_TO_DESIGN_VERILOG) $(PATH_TO_DESIGN_MEMS_VERILOG):
#	make -C ../sims/verilator CONFIG=$(DESIGN_CONFIG)

#
# 1. Swap the AXI SRAM out for an AXI to mem converter followed by a blackbox mem.
#

generated/$(DESIGN_NAME)_axi_to_mem.v: src/$(DESIGN_NAME)_axi_to_mem.sv | generated
	sv2v $< -w $@
# Add newline in the end of the file because sv2v does not.
	echo  >> $@

generated/$(DESIGN_NAME)_mem_top.v: src/$(DESIGN_NAME)_mem_top.sv | generated
	sv2v $< -w $@
# Add newline in the end of the file because sv2v does not.
	echo  >> $@

generated/out/vanilla.sv: $(DESIGN_SOURCES_TO_INSTRUMENT) | generated/out
	cat $^ > $@

generated/out/vanilla.sv.log: | generated/out
	touch $@

#
# 2. Replace the bootrom in Vanilla to have a dynamic ELF load.
#

$(PATH_TO_DESIGN_VERILOG_REPLACED_BOOTROM): $(PATH_TO_DESIGN_VERILOG) | generated
	$(PYTHON) ../cellift-common/python_scripts/replace_bootrom.py $^ $@


#
# 3. Instrument using Yosys.
#

YOSYS_INSTRUMENTATION_TARGETS_SV=$(patsubst %,generated/out/%_precompact.sv, cellift glift)

$(YOSYS_INSTRUMENTATION_TARGETS_SV): generated/out/%_precompact.sv: $(CELLIFT_YS)/instrument.ys.tcl generated/out/vanilla.sv | generated/out logs
	DECOMPOSE_MEMORY=1 VERILOG_INPUT=$(word 2,$^) INSTRUMENTATION=$* VERILOG_OUTPUT=$@ TOP_MODULE=$(TOP_MODULE) $(CELLIFT_META_ROOT)/resourcewrapper $(RESOURCEWRAPPER_TAG) $* instr yosys -DSYNTHESIS -c $< -l $@.log

generated/out/passthrough_precompact.sv: $(CELLIFT_YS)/passthrough_metareset.ys.tcl generated/out/vanilla.sv | generated/out logs
	DECOMPOSE_MEMORY=1 VERILOG_INPUT=$(word 2,$^) INSTRUMENTATION=$* VERILOG_OUTPUT=$@ TOP_MODULE=$(TOP_MODULE) yosys -DSYNTHESIS -c $< -l $@.log

#
# 4. Compacify the wide concatenations.
#

OUT_SV_TARGETS_NO_VANILLA=$(patsubst %,generated/out/%.sv, cellift glift passthrough)

$(OUT_SV_TARGETS_NO_VANILLA): generated/out/%.sv: generated/out/%_precompact.sv | generated/out logs
	$(PYTHON) $(CELLIFT_PYTHON_COMMON)/expand_left_operand.py $< generated/interm.sv
	$(PYTHON) $(CELLIFT_PYTHON_COMMON)/expand_right_operand.py $< generated/interm.sv
	$(PYTHON) $(CELLIFT_PYTHON_COMMON)/compress_concats.py generated/interm.sv generated/interm.sv
	$(PYTHON) $(CELLIFT_PYTHON_COMMON)/divide_concat_into_subconcats.py generated/interm.sv generated/interm.sv
	cat generated/interm.sv > $@
	rm -f generated/interm.sv
	cp $<.log $@.log

#
# 5. Build with Verilator through FuseSoC. The SRAM is added by FuseSoC directly.
#

# Phony targets

PREPARE_TARGETS_NOTRACE=$(patsubst %,prepare_%_notrace, $(TARGET_NAMES))
PREPARE_TARGETS_TRACE=$(patsubst %,prepare_%_trace, $(TARGET_NAMES))
PREPARE_TARGETS_TRACE_FST=$(patsubst %,prepare_%_trace_fst, $(TARGET_NAMES))
.PHONY: $(PREPARE_TARGETS_NOTRACE)  
$(PREPARE_TARGETS_NOTRACE) $(PREPARE_TARGETS_TRACE): prepare_%: build/run_%_0.1/default-verilator/$(TOP_EXECUTABLE_NAME)

# Actual targets

BUILD_TARGETS_NOTRACE=$(patsubst %,build/run_%_notrace_0.1/default-verilator/$(TOP_EXECUTABLE_NAME), $(TARGET_NAMES))
BUILD_TARGETS_TRACE=$(patsubst %,build/run_%_trace_0.1/default-verilator/$(TOP_EXECUTABLE_NAME), $(TARGET_NAMES))
BUILD_TARGETS_TRACE_FST=$(patsubst %,build/run_%_trace_fst_0.1/default-verilator/$(TOP_EXECUTABLE_NAME), $(TARGET_NAMES))

$(BUILD_TARGETS_NOTRACE): build/run_%_notrace_0.1/default-verilator/$(TOP_EXECUTABLE_NAME): generated/out/%.sv generated/out/%.sv.log
	rm -f fusesoc.conf
	fusesoc library add run_$*_notrace .
	CURR_CELLIFT_DIR=../cellift-$(RESOURCEWRAPPER_TAG) $(CELLIFT_META_ROOT)/resourcewrapper $(RESOURCEWRAPPER_TAG) $*_notrace synth fusesoc run --build run_$*_notrace
	cp $<.log $@.log
$(BUILD_TARGETS_TRACE): build/run_%_trace_0.1/default-verilator/$(TOP_EXECUTABLE_NAME): generated/out/%.sv generated/out/%.sv.log | traces
	rm -f fusesoc.conf
	fusesoc library add run_$*_trace .
	CURR_CELLIFT_DIR=../cellift-$(RESOURCEWRAPPER_TAG) $(CELLIFT_META_ROOT)/resourcewrapper $(RESOURCEWRAPPER_TAG) $*_trace synth fusesoc run --build run_$*_trace
	cp $<.log $@.log
$(BUILD_TARGETS_TRACE_FST): build/run_%_trace_fst_0.1/default-verilator/$(TOP_EXECUTABLE_NAME): generated/out/%.sv generated/out/%.sv.log | traces
	rm -f fusesoc.conf
	fusesoc library add run_$*_trace_fst .
	CURR_CELLIFT_DIR=../cellift-$(RESOURCEWRAPPER_TAG) $(CELLIFT_META_ROOT)/resourcewrapper $(RESOURCEWRAPPER_TAG) $*_trace_fst synth fusesoc run --build run_$*_trace_fst
	cp $<.log $@.log

#
# 6. Recompile, if only the sw has changed since the previous step.
#

RECOMPILE_TARGETS_NOTRACE=$(patsubst %,recompile_%_notrace, $(TARGET_NAMES))
RECOMPILE_TARGETS_TRACE=$(patsubst %,recompile_%_trace, $(TARGET_NAMES))
RECOMPILE_TARGETS_TRACE_FST=$(patsubst %,recompile_%_trace_fst, $(TARGET_NAMES))
RECOMPILE_TARGETS = $(RECOMPILE_TARGETS_NOTRACE) $(RECOMPILE_TARGETS_TRACE) $(RECOMPILE_TARGETS_TRACE_FST)

.PHONY: $(RECOMPILE_TARGETS)
$(RECOMPILE_TARGETS): recompile_%: build/run_%_0.1
	rm -f $</default-verilator/toplevel.o
	rm -f $</default-verilator/$(TOP_EXECUTABLE_NAME)
	rm -rf $</src/run_$*_0.1/dv
	rm -rf ./build/dv
	cp -r dv $</src/run_$*_0.1
	cp -r $(CELLIFT_DESIGN_PROCESSING_ROOT)/common/dv ./build
	make -C $</default-verilator

#
# 7. Rerun a simulation.
#

RERUN_TARGETS_NOTRACE=$(patsubst %,rerun_%_notrace, $(TARGET_NAMES))
RERUN_TARGETS_TRACE=$(patsubst %,rerun_%_trace, $(TARGET_NAMES))
RERUN_TARGETS_TRACE_FST=$(patsubst %,rerun_%_trace_fst, $(TARGET_NAMES))
RERUN_TARGETS = $(RERUN_TARGETS_NOTRACE) $(RERUN_TARGETS_TRACE) $(RERUN_TARGETS_TRACE_FST)

.PHONY: $(RERUN_TARGETS)
$(RERUN_TARGETS_TRACE) $(RERUN_TARGETS_TRACE_FST): | traces
$(RERUN_TARGETS): rerun_%: build/run_%_0.1/
	$</default-verilator/$(TOP_EXECUTABLE_NAME)

#
# 8. Run a simulation.
#

RUN_TARGETS_NOTRACE=$(patsubst %,run_%_notrace, $(TARGET_NAMES))
RUN_TARGETS_TRACE=$(patsubst %,run_%_trace, $(TARGET_NAMES))
RUN_TARGETS_TRACE_FST=$(patsubst %,run_%_trace_fst, $(TARGET_NAMES))
RUN_TARGETS = $(RUN_TARGETS_NOTRACE) $(RUN_TARGETS_TRACE) $(RUN_TARGETS_TRACE_FST)

$(RUN_TARGETS_TRACE) $(RUN_TARGETS_TRACE_FST): | traces
$(RUN_TARGETS): run_%: ./build/run_%_0.1/default-verilator/$(TOP_EXECUTABLE_NAME)
	cd build/run_$*_0.1/default-verilator && $(CELLIFT_META_ROOT)/resourcewrapper $(RESOURCEWRAPPER_TAG) $* run ./$(TOP_EXECUTABLE_NAME)

#
# Extract Yosys cell statistics.
#

STATISTICS_TARGETS=$(patsubst %,statistics/%.log, $(TARGET_NAMES))

$(STATISTICS_TARGETS): statistics/%.log: $(CELLIFT_YS)/statistics.ys.tcl generated/out/vanilla.sv | statistics
	DECOMPOSE_MEMORY=1 VERILOG_INPUT=$(word 2,$^) INSTRUMENTATION=$* TOP_MODULE=$(TOP_MODULE) $(CELLIFT_META_ROOT)/resourcewrapper $(RESOURCEWRAPPER_TAG) $* stat yosys -c $< -l $@
