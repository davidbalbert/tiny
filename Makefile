CC := clang
CFLAGS := --target=arm64-unknown-eabi -ffreestanding

AS := clang
ASFLAGS := --target=arm64-unknown-eabi

LD := /opt/homebrew/opt/llvm/bin/ld.lld
LDFLAGS := -nostdlib -T kernel.ld

.PHONY: run
run: kernel.elf
	qemu-system-aarch64 -machine virt -cpu cortex-a57 -kernel kernel.elf -nographic -serial mon:stdio

kernel.elf: boot.o kernel.o
	$(LD) $(LDFLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -f *.o *.elf

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<

%.o: %.s
	$(AS) -c $(ASFLAGS) -o $@ $<
