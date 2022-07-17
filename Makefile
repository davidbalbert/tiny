CC := clang
CFLAGS := -ffreestanding --target=arm64-unknown-eabi

ASFLAGS := --target=arm64-unknown-eabi

LD := /opt/homebrew/opt/llvm/bin/ld.lld
LDFLAGS := -nostdlib -T kernel.ld

OBJS := kernel.o boot.o

kernel: $(OBJS) kernel.ld
	$(LD) $(LDFLAGS) $(OBJS) -o kernel

.PHONY: run
run: kernel
	qemu-system-aarch64 -machine virt -cpu cortex-a57 -kernel kernel -nographic -serial mon:stdio

.PHONY: clean
clean:
	rm -f *.o kernel
