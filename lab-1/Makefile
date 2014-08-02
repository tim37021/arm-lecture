CC	= arm-linux-gnueabihf-gcc
OBJDUMP = arm-linux-gnueabihf-objdump
CFLAGS	= -O1 -Wall
LDFLAGS = -fno-stack-protector

objects	= fibseq.o fib.o

default: fibseq

.PHONY: default clean qemu

fibseq: $(objects)
	$(CC) $(LDFLAGS) -o $@ $^

fib.o: fib.s
fibseq.o: fibseq.c

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<

%.o: %.s
	$(CC) -c $(CFLAGS) -o $@ $<

cheat:
	$(CC) -c $(CFLAGS) fib_gcc.c
	$(OBJDUMP) -S fib_gcc.o > fib_gcc.txt

clean:
	rm -f $(objects) fib_gcc.o fibseq

QEMU_CMD = qemu-arm -L /usr/arm-linux-gnueabihf ./fibseq &
CMD = yes 9 | $(call QEMU_CMD) && sleep 1
qemu: fibseq
	@yes 5 | $(call QEMU_CMD)
	@sleep 1
	@yes 6 | $(call QEMU_CMD)
	@sleep 1
	@yes 7 | $(call QEMU_CMD)
	@sleep 1
