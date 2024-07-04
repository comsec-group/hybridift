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
    apt-get install -y libexpat1-dev libusb-dev libncurses5-dev cmake

############################
# Chipyard
############################

# Conda
RUN mkdir -p miniforge3 && wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O miniforge3/miniforge.sh \
        && cd miniforge3/ && bash miniforge.sh -u -b -p $PREFIX_HYBRIDIFT/miniforge3

ENV PATH="/miniforge3/bin/:${PATH}"

RUN git clone https://github.com/flaviens/hybridift-chipyard.git

# Install chipyard
RUN cd hybridift-chipyard && git checkout c45f449c4202487f80c8f77b348e8f1024eae607 && conda init \
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

# Install newer version of the tools than in CellIFT meta
# gtkwave
RUN apt-get install gtkwave

# Verilator 5.023 as said in the paper TODO Do the tag checkout also, else there will be internal errors in Verilator.
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && git clone https://github.com/verilator/verilator.git"
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && cd /verilator && autoconf"
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && cd /verilator && ./configure"
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && cd /verilator && make -j 220; echo ok"
RUN apt-get install -y help2man
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && cd /verilator && make install"

# sv2v, starting with stack
RUN apt-get install g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg netbase
RUN bash -c "source /cellift-meta/env.sh && wget -qO- https://get.haskellstack.org/ | sh"
RUN git clone https://github.com/zachjs/sv2v.git
RUN bash -c "source /cellift-meta/env.sh && cd /sv2v && make -j 220"

# CellIFT-yosys
RUN apt-get install -y  bison flex libreadline-dev gawk tcl-dev libffi-dev git graphviz xdot pkg-config python3 libboost-system-dev libboost-python-dev libboost-filesystem-dev zlib1g-dev
RUN git clone https://github.com/comsec-group/cellift-yosys.git
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-yosys && make config-gcc"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-yosys && make -j 220"

# Rust
RUN bash -c "source /cellift-meta/env.sh && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

# Bender and Morty
RUN bash -c "source /cellift-meta/env.sh && cargo install bender"
RUN bash -c "source /cellift-meta/env.sh && cargo install morty"

# FuseSoC
RUN bash -c "source /cellift-meta/env.sh && pip3 install --upgrade --user fusesoc"

# The RISC-V toolchain
RUN apt-get install -y autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev
RUN git clone https://github.com/riscv/riscv-gnu-toolchain
RUN bash -c "source /cellift-meta/env.sh && cd riscv-gnu-toolchain/ && ./configure --prefix=/root/prefix-cellift/riscv --with-arch=rv32imc --with-cmodel=medlow --enable-multilib && make -j 220"

# Spike
RUN git clone https://github.com/riscv-software-src/riscv-isa-sim.git
RUN apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libboost-iostreams-dev
RUN bash -c "source /cellift-meta/env.sh && mkdir -p /riscv-isa-sim/build && cd /riscv-isa-sim/build && ../configure --prefix=/root/prefix-cellift/riscv && make -j 220 && make install"

############################
# Chipyard preparation
############################

# RUN mkdir -p facilities
# COPY facilities/chipyard/chipyard.tgz /facilities/chipyard.tgz
# # Untar chipyard
# RUN tar -xzf facilities/chipyard.tgz -C /facilities
# RUN bash -c "cp -r /facilities/cellift-rocket /hybridift-chipyard"
# RUN bash -c "cp -r /facilities/cellift-boom   /hybridift-chipyard"
# RUN bash -c "cp -r /facilities/cellift-common /hybridift-chipyard"
# RUN cp facilities/BoomConfigs.scala /hybridift-chipyard/generators/chipyard/src/main/scala/config/BoomConfigs.scala

# RUN touch /cellift-meta/design-processing/common/modelsim.mk
# RUN bash -c "source /cellift-meta/env.sh && cd /hybridift-chipyard/cellift-rocket && make generated/out/vanilla.sv"

RUN git clone https://github.com/comsec-group/cellift-chipyard.git
RUN bash -c "cd /cellift-chipyard && CASCADE_JOBS=250 scripts/init-submodules-no-riscv-tools.sh --skip-validate"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard && make -C sims/verilator CONFIG=MySmallVMRocketConfig; echo Rocket ok"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard && make -C sims/verilator CONFIG=MySmallBoomConfig; echo BOOM ok"
# RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-rocket && make generated/out/vanilla.sv"

ENV PATH="/sv2v/bin/:${PATH}"

# Generate Vanilla
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-rocket && make generated/out/vanilla.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-boom   && make generated/out/vanilla.sv"

############################
# CVA6 preparation
############################

RUN git clone https://github.com/comsec-group/cellift-cva6.git
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && make generated/out/vanilla.sv"

ENV PATH="/cellift-yosys/:${PATH}"

############################
# Chipyard some more preparation
############################

# CellIFT for Chipyard designs, a bit OoO, waiting for OpenC910 to be ready :)
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-rocket && make generated/out/cellift.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-boom   && make generated/out/cellift.sv"

############################
# OpenC910 preparation
############################

RUN mkdir -p facilities
COPY facilities/openc910/openc910.tgz /openc910.tgz

# Untar OpenC910
RUN tar -xzf openc910.tgz
RUN bash -c "source /cellift-meta/env.sh && cd /openc910/our && make generated/out/vanilla.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /openc910/our && make generated/out/cellift.sv"

############################
# Finally, CVA6 CellIFT
############################

# In a later stage, merge this with the vanilla build. This is because we changed bender.yml upstream
RUN bash -c "source /cellift-meta/env.sh && rm -rf /cellift-cva6"
RUN git clone https://github.com/comsec-group/cellift-cva6.git
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && make generated/out/vanilla.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && make generated/out/cellift.sv"

############################
# Do the passthroughs for HybriDIFT
############################

RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && make generated/out/passthrough.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-rocket/ && make generated/out/passthrough.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-chipyard/cellift-boom/ && make generated/out/passthrough.sv"

RUN bash -c "sed -i 's/yosys list_state_elements/ yosys timestamp list_state_elements_dummy/g' /cellift-meta/design-processing/common/yosys/instrument.ys.tcl"
RUN bash -c "source /cellift-meta/env.sh && cd /openc910/our && make generated/passthrough_precompact.sv"

############################
# HybriDIFT
############################

# Create the template files
COPY facilities/hybridift_dv/testbench_template.h /cellift-meta/design-processing/common/hybridift_dv/testbench_template.h
COPY facilities/hybridift_dv/toplevel_template.cc /cellift-meta/design-processing/common/hybridift_dv/toplevel_template.cc

COPY facilities/hybridift.py /hybridift.py
# Start with CVA6
# First, pre-instrument the memories
RUN bash -c "source /cellift-meta/env.sh && python3 /hybridift.py /cellift-cva6/cellift/generated/out/passthrough.sv /cellift-cva6/cellift/generated/hybridift_interm.sv"
# Imprecise shr sshr
COPY facilities/yosys/instrument.ys.tcl /cellift-meta/design-processing/common/yosys/instrument.ys.tcl

# Then, instrument the rest of the design
RUN bash -c "DECOMPOSE_MEMORY=1 VERILOG_INPUT=/cellift-cva6/cellift/generated/hybridift_interm.sv INSTRUMENTATION=cellift VERILOG_OUTPUT=/cellift-cva6/cellift/generated/out/hybridift.sv TOP_MODULE=ariane_mem_top yosys -c /cellift-meta/design-processing/common/yosys/instrument.ys.tcl -l /cellift-cva6/cellift/generated/out/hybridift.log"

# Some processing
RUN bash -c "mv /cellift-cva6/cellift/generated/out/hybridift.sv /cellift-cva6/cellift/generated/hybridift_precompact.sv"
COPY facilities/cellift-meta/concatbitwidth.py /cellift-meta/design-processing/common/python_scripts/concatbitwidth.py
RUN sed 's/\$func\$\/cellift-cva6\/cellift\/generated\/hybridift_interm.sv/mypath/g' /cellift-cva6/cellift/generated/hybridift_precompact.sv > /cellift-cva6/cellift/generated/interm.sv
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && python3 /cellift-meta/design-processing/common/python_scripts/expand_left_operand.py generated/interm.sv generated/interm.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && python3 /cellift-meta/design-processing/common/python_scripts/expand_right_operand.py generated/interm.sv generated/interm.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && python3 /cellift-meta/design-processing/common/python_scripts/compress_concats.py generated/interm.sv generated/interm.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && python3 /cellift-meta/design-processing/common/python_scripts/divide_concat_into_subconcats.py generated/interm.sv generated/interm.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && python3 /cellift-meta/design-processing/common/python_scripts/correct_too_wide_lvalues.py generated/interm.sv generated/interm.sv"
# RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && python3 /cellift-meta/design-processing/common/python_scripts/remove_clkt0.py generated/interm.sv generated/interm.sv"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && sed 's/assign xx_intc_vld/\/\/assign xx_intc_vld/g' generated/interm.sv > generated/out/hybridift.sv"

# Verilator 5.023 as said in the paper
RUN rm -rf /verilator
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && git clone https://github.com/verilator/verilator.git"
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && cd /verilator && git checkout v5.022"
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && cd /verilator && autoconf"
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && cd /verilator && ./configure"
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && cd /verilator && make -j 220; echo ok"
RUN apt-get install -y help2man
RUN bash -c "unset VERILATOR_ROOT && source /cellift-meta/env.sh && cd /verilator && make install"

COPY facilities/cva6/run_hybridift_notrace.core /cellift-cva6/cellift/run_hybridift_notrace.core
COPY facilities/cva6/ift_sram_mem.sv /cellift-cva6/cellift/src/ift_sram_mem.sv
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/ && /root/.local/bin/fusesoc library add run_hybridift_notrace . && /root/.local/bin/fusesoc run --build run_hybridift_notrace"
# This command below will naturally fail because a SIMSRAMELF argument must be provided (see CellIFT tooling). But it compiles and allows fast prototyping once compiling, which is the goal.
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-cva6/cellift/build/run_hybridift_notrace_0.1/default-verilator/ && SIMLEN=1000 ./Variane_tiny_soc; echo ok"

# Openc910

# Update the Yosys version
RUN bash -c "source /cellift-meta/env.sh && git config --global user.email artifacts@hybridift.com && git config --global user.name HybriDIFT Artifacts"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-yosys/ && git remote add github https://github.com/YosysHQ/yosys.git && git fetch github && git rebase yosys-0.39"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-yosys/passes/cellift && find . -type f -exec sed -i 's/.database./.get_database()./g' {} + && find ../cmds -type f -exec sed -i 's/.database./.get_database()./g' {} +"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-yosys/ && make config-gcc && make -j 220"

# sed -i 's/.database./.get_database()./g' passes/cellift/cellift.cc && make -j 220"
RUN bash -c "source /cellift-meta/env.sh && cd /openc910/our && cp generated/sv2v_out.v generated/sv2v_out_copy.v"
COPY facilities/openc910/sram_mem_blackbox.sv /openc910/sram_mem_blackbox.sv
RUN bash -c "source /cellift-meta/env.sh && cd /openc910/our && cat /openc910/sram_mem_blackbox.sv >> generated/sv2v_out.v"

COPY facilities/openc910/Makefile /openc910/our/Makefile
COPY facilities/yosys/passthrough_metareset.ys.tcl /cellift-meta/design-processing/common/yosys/

# Add yosys metareset
COPY facilities/yosys/meta_reset.cc /cellift-yosys/passes/cmds/meta_reset.cc
RUN bash -c "source /cellift-meta/env.sh && echo 'OBJS += passes/cmds/meta_reset.o' >> /cellift-yosys/passes/cmds/Makefile.inc"
RUN bash -c "source /cellift-meta/env.sh && cd /cellift-yosys/ && make -j 220"

RUN bash -c "source /cellift-meta/env.sh && cd /openc910/our && make generated/passthrough_precompact.sv"

# RUN bash -c "source /cellift-meta/env.sh && python3 /hybridift.py /openc910/our/generated/passthrough_precompact.sv /openc910/our/generated/hybridift_interm.sv"
