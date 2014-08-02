	.syntax unified
	.arch armv7-a
	.text

	.equ locked, 1
	.equ unlocked, 0

	.global lock_mutex
	.type lock_mutex, function
lock_mutex:
        @ INSERT CODE BELOW
	@ Reference: http://electronics.stackexchange.com/questions/25690/critical-sections-on-cortex-m3
	@ Reference: http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dht0008a/ch01s03s02.html

	push {r1, r2}
	ldr r2, =locked
.WAIT_LOCK:
	@Reference book: Introduction to Parallel Programming, you can find this book at http://prdrklaina.weebly.com/uploads/5/7/7/3/5773421/an_introduction_to_parallel_programming_-_peter_s._pacheco.pdf
	@check if it is locked, wait until find it unlocked
	ldrex r1, [r0]
	cmp r1, #locked
	beq .WAIT_LOCK

	@try to use the lock, needs to check if locked again because context-switch may happen here
	strex r1, r2, [r0]
	@if fails, waiting again
	cmp r1, #1
	beq .WAIT_LOCK

	pop {r1, r2}

        @ END CODE INSERT
	bx lr

	.size lock_mutex, .-lock_mutex

	.global unlock_mutex
	.type unlock_mutex, function
unlock_mutex:
	@ INSERT CODE BELOW
        
	push {r1}
	mov r1, #unlocked
	str r1, [r0]
	pop {r1}

        @ END CODE INSERT
	bx lr
	.size unlock_mutex, .-unlock_mutex

	.end
