FROM ubuntu@sha256:b5a61709a9a44284d88fb12e5c48db0409cfad5b69d4ff8224077c57302df9cf
RUN apt-get update && apt-get install -y curl gnupg apt-utils && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    autoconf automake autotools-dev libmpc-dev libmpfr-dev libgmp-dev gawk build-essential \
    bison flex texinfo gperf libtool patchutils bc zlib1g-dev git perl python3 make g++ libfl2 \
    libfl-dev zlib1g zlib1g-dev git autoconf flex bison gtkwave python3.9 python3.9-venv clang \
    tcl-dev libreadline-dev jq libexpat-dev device-tree-compiler vim && \
    apt-get install -y sbt && \
    apt-get install -y software-properties-common  default-jdk default-jre gengetopt && \
    apt-get install -y patch diffstat texi2html subversion chrpath wget && \
    apt-get install -y libgtk-3-dev gettext && \
    apt-get install -y python3-pip python3.8-dev rsync libguestfs-tools expat ctags && \
    apt-get install -y libexpat1-dev libusb-dev libncurses5-dev cmake gtkwave help2man python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk ninja-build libglib2.0-dev libslirp-dev && \
    apt-get install -y libc6-dev libffi-dev xz-utils gnupg netbase && \
    apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libboost-iostreams-dev && \
    apt-get install && add-apt-repository ppa:deadsnakes/ppa && apt-get update -y && apt-get install python3.12 -y

############################
# Chipyard
############################

# Conda
RUN mkdir -p miniforge3 && wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O miniforge3/miniforge.sh \
        && cd miniforge3/ && bash miniforge.sh -u -b -p $PREFIX_HYBRIDIFT/miniforge3
ENV PATH="/miniforge3/bin/:${PATH}"

# Install chipyard
RUN git clone https://github.com/flaviens/hybridift-chipyard.git && cd hybridift-chipyard && git checkout c45f449c4202487f80c8f77b348e8f1024eae607 && conda init \
    && . ~/.bashrc \
    && conda create --name chipyard-env python=3.10 \
    && conda activate chipyard-env \
    && conda install -n chipyard-env conda-libmamba-solver \
    && conda config --set solver libmamba \
    && conda install -n chipyard-env conda-lock==1.4.0 \
    && ./scripts/init-submodules-no-riscv-tools.sh


############################
# CellIFT meta and tools
############################

# Not a recursive clone. We will clone the tools separately.
RUN git clone https://github.com/comsec-group/cellift-meta.git
RUN echo "export CELLIFT_JOBS=220" >> /cellift-meta/env.sh
# TODO Replace with this single-line:
# RUN bash -c "git clone https://github.com/comsec-group/cellift-meta.git && echo 'export CELLIFT_JOBS=220' >> /cellift-meta/env.sh"

# Verilator 5.022/5.023 as said in the paper
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && git clone https://github.com/verilator/verilator.git && cd /verilator && git checkout v5.022 && cd /verilator && autoconf && cd /verilator && ./configure && cd /verilator && make -j 220; echo ok && cd /verilator && make install"

# sv2v, starting with stack
RUN bash -c "source /cellift-meta/env.sh && wget -qO- https://get.haskellstack.org/ | sh"
RUN git clone https://github.com/zachjs/sv2v.git
RUN bash -c "source /cellift-meta/env.sh && cd /sv2v && make -j 220"

# CellIFT-yosys
# Add yosys metareset
# COPY facilities/yosys/meta_reset.cc /cellift-yosys/passes/cmds/meta_reset.cc
# RUN bash -c "source /cellift-meta/env.sh && echo 'OBJS += passes/cmds/meta_reset.o' >> /cellift-yosys/passes/cmds/Makefile.inc"
# Update the Yosys version and make it
# RUN bash -c "source /cellift-meta/env.sh && git config --global user.email artifacts@hybridift.com && git config --global user.name HybriDIFT Artifacts && cd /cellift-yosys/ && git remote add github https://github.com/YosysHQ/yosys.git && git fetch github && git rebase yosys-0.39 && cd /cellift-yosys/passes/cellift && find . -type f -exec sed -i 's/.database./.get_database()./g' {} + && find ../cmds -type f -exec sed -i 's/.database./.get_database()./g' {} + && source /cellift-meta/env.sh && cd /cellift-yosys && make config-gcc && make -j 220"
RUN bash -c "source /cellift-meta/env.sh && git clone https://github.com/comsec-group/cellift-yosys.git --recursive && cd /cellift-yosys && make config-gcc && make -j 220"
ENV PATH="/cellift-yosys/:${PATH}"

# Rust, Bender, Morty, FuseSoC, risc-v toolchain and spike
RUN bash -c "source /cellift-meta/env.sh && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && cd / && cargo install bender && cargo install morty && pip3 install --upgrade --user fusesoc && cd / && git clone https://github.com/riscv/riscv-gnu-toolchain && cd riscv-gnu-toolchain/ && ./configure --prefix=/root/prefix-cellift/riscv --with-arch=rv32imc --with-cmodel=medlow --enable-multilib && make -j 220 && cd / && git clone https://github.com/riscv-software-src/riscv-isa-sim.git && source /cellift-meta/env.sh && mkdir -p /riscv-isa-sim/build && cd /riscv-isa-sim/build && ../configure --prefix=/root/prefix-cellift/riscv && make -j 220 && make install"

############################
# Chipyard preparation
############################

RUN bash -c "git clone https://github.com/comsec-group/cellift-chipyard.git && cd /cellift-chipyard && CASCADE_JOBS=250 scripts/init-submodules-no-riscv-tools.sh --skip-validate && source /cellift-meta/env.sh && cd /cellift-chipyard && make -C sims/verilator CONFIG=MySmallVMRocketConfig; echo Rocket ok && cd /cellift-chipyard && make -C sims/verilator CONFIG=MySmallBoomConfig; echo BOOM ok"
ENV PATH="/sv2v/bin/:${PATH}"

# Generate Vanilla and CellIFT
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-rocket && make generated/out/vanilla.sv && make generated/out/cellift.sv && make generated/out/passthrough.sv && cd /cellift-chipyard/cellift-boom && make generated/out/vanilla.sv && make generated/out/cellift.sv && make generated/out/passthrough.sv"

############################
# CVA6 preparation
############################

RUN bash -c "source /cellift-meta/env.sh && git clone https://github.com/comsec-group/cellift-cva6.git && cd /cellift-cva6/cellift/ && make generated/out/vanilla.sv && make generated/out/cellift.sv"

############################
# OpenC910 preparation
############################

COPY facilities/openc910/openc910.tgz /openc910.tgz
# Untar OpenC910 and make it
RUN bash -c "source /cellift-meta/env.sh && tar -xzf openc910.tgz && cd /openc910/our && make generated/out/vanilla.sv"

# TODO Uncomment later
# RUN bash -C "source /cellift-meta/env.sh && cd /openc910/our && make generated/out/passthrough.sv"
# RUN bash -C "source /cellift-meta/env.sh && cd /openc910/our && make generated/out/cellift.sv"

# TODO Eventually remove this
RUN bash -c "source /cellift-meta/env.sh && rm -rf cellift-meta && git clone https://github.com/comsec-group/cellift-meta.git && echo 'export CELLIFT_JOBS=220' >> /cellift-meta/env.sh"
# RUN bash -c "source /cellift-meta/env.sh && rm -rf cellift-yosys && git clone https://github.com/comsec-group/cellift-yosys.git --recursive && cd /cellift-yosys && make config-gcc && make -j 220"

# Passthrough precompact
RUN bash -c "sed -i 's/yosys list_state_elements/ yosys timestamp list_state_elements_dummy/g' /cellift-meta/design-processing/common/yosys/instrument.ys.tcl && source /cellift-meta/env.sh && cd /openc910/our && make generated/passthrough_precompact.sv"

############################
# HybriDIFT
############################

# Create the template files
COPY facilities/hybridift_dv/testbench_template.h /cellift-meta/design-processing/common/hybridift_dv/testbench_template.h
COPY facilities/hybridift_dv/toplevel_template.cc /cellift-meta/design-processing/common/hybridift_dv/toplevel_template.cc
COPY facilities/hybridift.py /hybridift.py
# Imprecise shr sshr
COPY facilities/yosys/instrument.ys.tcl /cellift-meta/design-processing/common/yosys/instrument.ys.tcl

# TODO Merge with the above
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && make generated/out/passthrough.sv"

# Start with CVA6
# First, pre-instrument the memories. Then, instrument the rest of the design.
# TODO Remove
# COPY facilities/hybridift.py /hybridift.py

RUN bash -c "source /cellift-meta/env.sh && python3 /hybridift.py /cellift-cva6/cellift/generated/out/passthrough.sv /cellift-cva6/cellift/generated/hybridift_interm.sv"
RUN bash -c "source /cellift-meta/env.sh && DECOMPOSE_MEMORY=1 VERILOG_INPUT=/cellift-cva6/cellift/generated/hybridift_interm.sv INSTRUMENTATION=cellift VERILOG_OUTPUT=/cellift-cva6/cellift/generated/out/hybridift.sv TOP_MODULE=ariane_mem_top yosys -c /cellift-meta/design-processing/common/yosys/instrument.ys.tcl -l /cellift-cva6/cellift/generated/out/hybridift.log"

# HybriDIFT, then some processing
RUN bash -c "mv /cellift-cva6/cellift/generated/out/hybridift.sv /cellift-cva6/cellift/generated/hybridift_precompact.sv && sed 's/\$func\$\/cellift-cva6\/cellift\/generated\/hybridift_interm.sv/mypath/g' /cellift-cva6/cellift/generated/hybridift_precompact.sv > /cellift-cva6/cellift/generated/interm.sv && source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && python3 /cellift-meta/design-processing/common/python_scripts/expand_left_operand.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/expand_right_operand.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/compress_concats.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/divide_concat_into_subconcats.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/correct_too_wide_lvalues.py generated/interm.sv generated/interm.sv && sed 's/assign xx_intc_vld/\/\/assign xx_intc_vld/g' generated/interm.sv > generated/out/hybridift.sv"

COPY facilities/cva6/run_hybridift_notrace.core /cellift-cva6/cellift/run_hybridift_notrace.core
COPY facilities/cva6/ift_sram_mem.sv /cellift-cva6/cellift/src/ift_sram_mem.sv
# The last command below will naturally fail because a SIMSRAMELF argument must be provided (see CellIFT tooling). But it compiles and allows fast prototyping once compiling, which is the goal.
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && /root/.local/bin/fusesoc library add run_hybridift_notrace . && /root/.local/bin/fusesoc run --build run_hybridift_notrace && cd /cellift-cva6/cellift/build/run_hybridift_notrace_0.1/default-verilator/ && SIMLEN=1000 ./Variane_tiny_soc; echo ok"

# Openc910

# sed -i 's/.database./.get_database()./g' passes/cellift/cellift.cc && make -j 220"
RUN bash -c "source /cellift-meta/env.sh && cd /openc910/our && cat /openc910/sram_mem_blackbox.sv >> generated/sv2v_out.v && make generated/passthrough_precompact.sv"

# Remove unused modules. Then, instrument the rest of the design.
RUN bash -c "source /cellift-meta/env.sh && python3 /cellift-meta/design-processing/common/python_scripts/remove_unused_modules.py /openc910/our/generated/passthrough_precompact.sv /openc910/our/generated/passthrough_precompact_smaller.sv openc910_mem_top"
# TODO Remove
# COPY facilities/hybridift.py /hybridift.py
RUN bash -c "source /cellift-meta/env.sh && python3 /hybridift.py  /openc910/our/generated/passthrough_precompact_smaller.sv /openc910/our/generated/hybridift_interm.sv"
RUN bash -c "source /cellift-meta/env.sh && DECOMPOSE_MEMORY=1 VERILOG_INPUT=/openc910/our/generated/hybridift_interm.sv INSTRUMENTATION=cellift VERILOG_OUTPUT=/openc910/our/generated/out/hybridift.sv TOP_MODULE=openc910_mem_top yosys -c /cellift-meta/design-processing/common/yosys/instrument.ys.tcl -l /openc910/our/generated/out/hybridift.log"

# Some more processing
RUN bash -c "mv /openc910/our/generated/out/hybridift.sv /openc910/our/generated/hybridift_precompact.sv && sed 's/\$func\$\/cellift-cva6\/cellift\/generated\/hybridift_interm.sv/mypath/g' /openc910/our/generated/hybridift_precompact.sv > /openc910/our/generated/interm.sv && source /cellift-meta/env.sh && cd /openc910/our/ && python3 /cellift-meta/design-processing/common/python_scripts/expand_left_operand.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/expand_right_operand.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/compress_concats.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/divide_concat_into_subconcats.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/correct_too_wide_lvalues.py generated/interm.sv generated/interm.sv && cd /openc910/our/ && sed 's/assign xx_intc_vld/\/\/assign xx_intc_vld/g' generated/interm.sv > generated/out/hybridift.sv"

# # TODO Remove this eventually
COPY facilities/openc910/replace_unwanted_t0s.py /replace_unwanted_t0s.py

RUN bash -c "source /cellift-meta/env.sh && cd /openc910/our/ && python3 /replace_unwanted_t0s.py generated/out/hybridift.sv generated/out/hybridift.sv && /root/.local/bin/fusesoc library add run_hybridift_notrace . && /root/.local/bin/fusesoc run --build run_hybridift_notrace"
# This command below will naturally fail because a SIMSRAMELF argument must be provided (see CellIFT tooling). But it compiles and allows fast prototyping once compiling, which is the goal.
RUN bash -c "source /cellift-meta/env.sh && cd /openc910/our/build/run_hybridift_notrace_0.1/default-verilator/ && SIMLEN=1000 ./Vopenc910_tiny_soc; echo ok"

# Rocket and BOOM

# Add metareset to Rocket and BOOM
COPY facilities/rocket/cellift-common.mk /cellift-chipyard/cellift-common/cellift-common.mk
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-rocket && make generated/out/passthrough_precompact.sv && cd /cellift-chipyard/cellift-boom && make generated/out/passthrough_precompact.sv"

# Annotate
COPY facilities/rocket/annotate_chipyard_mems.py /annotate_chipyard_mems.py
RUN bash -c "source /cellift-meta/env.sh && python3 /annotate_chipyard_mems.py /cellift-chipyard/cellift-rocket/generated/out/passthrough_precompact.sv /cellift-chipyard/cellift-rocket/generated/passthrough_precompact_annotated.sv && python3 /annotate_chipyard_mems.py /cellift-chipyard/cellift-boom/generated/out/passthrough_precompact.sv /cellift-chipyard/cellift-boom/generated/passthrough_precompact_annotated.sv"

# Hybridift-ize
COPY facilities/hybridift_a2.py /hybridift.py
# RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-rocket && python3 /hybridift.py generated/passthrough_precompact_annotated.sv generated/hybridift_interm.sv --annotations && cd /cellift-chipyard/cellift-boom && python3 /hybridift.py generated/passthrough_precompact_annotated.sv generated/hybridift_interm.sv --annotations"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-rocket && python3 /hybridift.py generated/passthrough_precompact_annotated.sv generated/hybridift_interm.sv --annotations"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-boom && python3 /hybridift.py generated/passthrough_precompact_annotated.sv generated/hybridift_interm.sv --annotations"

# CellIFT-ize the non-memory parts of the design
RUN bash -c "source /cellift-meta/env.sh && DECOMPOSE_MEMORY=1 VERILOG_INPUT=/cellift-chipyard/cellift-rocket/generated/hybridift_interm.sv INSTRUMENTATION=cellift VERILOG_OUTPUT=/cellift-chipyard/cellift-rocket/generated/out/hybridift.sv TOP_MODULE=rocket_mem_top yosys -c /cellift-meta/design-processing/common/yosys/instrument.ys.tcl -l /cellift-chipyard/cellift-rocket/generated/hybridift.log"

RUN bash -c "mv /cellift-chipyard/cellift-rocket/generated/out/hybridift.sv /cellift-chipyard/cellift-rocket/generated/hybridift_precompact.sv && sed 's/\$func\$\/cellift-cva6\/cellift\/generated\/hybridift_interm.sv/mypath/g' /cellift-chipyard/cellift-rocket/generated/hybridift_precompact.sv > /cellift-chipyard/cellift-rocket/generated/interm.sv && source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-rocket/ && python3 /cellift-meta/design-processing/common/python_scripts/expand_left_operand.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/expand_right_operand.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/compress_concats.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/divide_concat_into_subconcats.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/correct_too_wide_lvalues.py generated/interm.sv generated/interm.sv && cd /cellift-chipyard/cellift-rocket/ && sed 's/assign xx_intc_vld/\/\/assign xx_intc_vld/g' generated/interm.sv > generated/out/hybridift.sv"


# Replace unwanted t0's
COPY facilities/replace_unwanted_t0s_2.py /replace_unwanted_t0s.py
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-rocket/ && python3 /replace_unwanted_t0s.py generated/out/hybridift.sv generated/out/hybridift.sv"

COPY facilities/rocket/run_hybridift_notrace.core /cellift-chipyard/cellift-rocket/run_hybridift_notrace.core
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-rocket/ && /root/.local/bin/fusesoc library add run_hybridift_notrace . && /root/.local/bin/fusesoc run --build run_hybridift_notrace && cd /cellift-chipyard/cellift-rocket/build/run_hybridift_notrace_0.1/default-verilator/"

# BOOM
RUN bash -c "source /cellift-meta/env.sh && DECOMPOSE_MEMORY=1 VERILOG_INPUT=/cellift-chipyard/cellift-boom/generated/hybridift_interm.sv INSTRUMENTATION=cellift VERILOG_OUTPUT=/cellift-chipyard/cellift-boom/generated/out/hybridift.sv TOP_MODULE=boom_mem_top yosys -c /cellift-meta/design-processing/common/yosys/instrument.ys.tcl -l /cellift-chipyard/cellift-boom/generated/hybridift.log"
RUN bash -c "mv /cellift-chipyard/cellift-boom/generated/out/hybridift.sv /cellift-chipyard/cellift-boom/generated/hybridift_precompact.sv && sed 's/\$func\$\/cellift-cva6\/cellift\/generated\/hybridift_interm.sv/mypath/g' /cellift-chipyard/cellift-boom/generated/hybridift_precompact.sv > /cellift-chipyard/cellift-boom/generated/interm.sv && source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-boom/ && python3 /cellift-meta/design-processing/common/python_scripts/expand_left_operand.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/expand_right_operand.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/compress_concats.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/divide_concat_into_subconcats.py generated/interm.sv generated/interm.sv && python3 /cellift-meta/design-processing/common/python_scripts/correct_too_wide_lvalues.py generated/interm.sv generated/interm.sv && cd /cellift-chipyard/cellift-boom/ && sed 's/assign xx_intc_vld/\/\/assign xx_intc_vld/g' generated/interm.sv > generated/out/hybridift.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-boom/ && python3 /replace_unwanted_t0s.py generated/out/hybridift.sv generated/out/hybridift.sv"
RUN bash -c "cp /cellift-chipyard/cellift-rocket/run_hybridift_notrace.core /cellift-chipyard/cellift-boom/run_hybridift_notrace.core && source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-boom/ && /root/.local/bin/fusesoc library add run_hybridift_notrace . && /root/.local/bin/fusesoc run --build run_hybridift_notrace && cd /cellift-chipyard/cellift-boom/build/run_hybridift_notrace_0.1/default-verilator/"




# # TODO " && SIMLEN=1000 ./Vtop_tiny_soc; echo ok"


# RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-boom && python3 /hybridift.py generated/passthrough_precompact_annotated.sv generated/hybridift_interm.sv --annotations"

# RUN bash -c "source /cellift-meta/env.sh && echo TODO Continuer ici"


