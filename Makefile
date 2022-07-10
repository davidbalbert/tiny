CC := clang
CFLAGS := -ffreestanding --target=arm64-unknown-eabi

ASFLAGS := --target=arm64-unknown-eabi

LD := /opt/homebrew/opt/llvm/bin/ld.lld
LDFLAGS := -nostdlib -T kernel.ld
LINK.o := $(LD) $(LDFLAGS) $(TARGET_ARCH)

.PHONY: run
run: kernel
	qemu-system-aarch64 -machine virt -cpu cortex-a57 -kernel kernel -nographic -serial mon:stdio

kernel: kernel.o boot.o

.PHONY: clean
clean:
	rm -f *.o kernel
