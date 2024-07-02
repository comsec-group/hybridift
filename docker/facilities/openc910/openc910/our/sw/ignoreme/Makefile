RISCV_PREFIX = riscv32-unknown-elf


RV_ARCH_FLAGS ?= -march=rv64g -mabi=lp64
RISCV_GCC_OPTS ?= $(RV_ARCH_FLAGS) -DPREALLOCATE=1 -mcmodel=medany -static -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf -fno-tree-loop-distribute-patterns -gdwarf-2
LDFLAGS = -Tlink.ld -static -nostdlib -nostartfiles -lm -lgcc
RISCV_OBJDUMP ?= $(RISCV_PREFIX)-objdump -d

CC = $(RISCV_PREFIX)-gcc

# # Edit the rounding mode
# build/app.elf: build/app_nobbe.elf
# 	bbe -e 's/\xd3\x82\x00\xd2/\xd3\xa2\x00\xd2/g' $< -o $@
# 	$(RISCV_OBJDUMP) $@ > $@.dump

build/app.elf: main.S link.ld | build
	$(CC) $(RISCV_GCC_OPTS) $< -o $@ $(LDFLAGS)
	$(RISCV_OBJDUMP) $@ > $@.dump

build:
	mkdir -p build

.PHONY: clean
clean:
	rm -rf build
