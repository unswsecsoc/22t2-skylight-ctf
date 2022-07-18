# Automatically generated file - do not edit

DEPINCLUDES+=-I$S/mipseb

mips.o: $S/mipseb/mips.c
	$(CC) $(CFLAGS) -I$S/mipseb -c $S/mipseb/mips.c
SRCS+=$S/mipseb/mips.c
OBJS+=mips.o

bootrom.o: $S/mipseb/bootrom.c
	$(CC) $(CFLAGS) -I$S/mipseb -c $S/mipseb/bootrom.c
SRCS+=$S/mipseb/bootrom.c
OBJS+=bootrom.o

DEPINCLUDES+=-I$S/bus

lamebus.o: $S/bus/lamebus.c
	$(CC) $(CFLAGS) -I$S/bus -c $S/bus/lamebus.c
SRCS+=$S/bus/lamebus.c
OBJS+=lamebus.o

boot.o: $S/bus/boot.c
	$(CC) $(CFLAGS) -I$S/bus -c $S/bus/boot.c
SRCS+=$S/bus/boot.c
OBJS+=boot.o

dev_disk.o: $S/bus/dev_disk.c
	$(CC) $(CFLAGS) -I$S/bus -c $S/bus/dev_disk.c
SRCS+=$S/bus/dev_disk.c
OBJS+=dev_disk.o

dev_emufs.o: $S/bus/dev_emufs.c
	$(CC) $(CFLAGS) -I$S/bus -c $S/bus/dev_emufs.c
SRCS+=$S/bus/dev_emufs.c
OBJS+=dev_emufs.o

dev_net.o: $S/bus/dev_net.c
	$(CC) $(CFLAGS) -I$S/bus -c $S/bus/dev_net.c
SRCS+=$S/bus/dev_net.c
OBJS+=dev_net.o

dev_random.o: $S/bus/dev_random.c
	$(CC) $(CFLAGS) -I$S/bus -c $S/bus/dev_random.c
SRCS+=$S/bus/dev_random.c
OBJS+=dev_random.o

dev_screen.o: $S/bus/dev_screen.c
	$(CC) $(CFLAGS) -I$S/bus -c $S/bus/dev_screen.c
SRCS+=$S/bus/dev_screen.c
OBJS+=dev_screen.o

dev_serial.o: $S/bus/dev_serial.c
	$(CC) $(CFLAGS) -I$S/bus -c $S/bus/dev_serial.c
SRCS+=$S/bus/dev_serial.c
OBJS+=dev_serial.o

dev_timer.o: $S/bus/dev_timer.c
	$(CC) $(CFLAGS) -I$S/bus -c $S/bus/dev_timer.c
SRCS+=$S/bus/dev_timer.c
OBJS+=dev_timer.o

dev_trace.o: $S/bus/dev_trace.c
	$(CC) $(CFLAGS) -I$S/bus -c $S/bus/dev_trace.c
SRCS+=$S/bus/dev_trace.c
OBJS+=dev_trace.o

DEPINCLUDES+=-I$S/gdb

gdb_fe.o: $S/gdb/gdb_fe.c
	$(CC) $(CFLAGS) -I$S/gdb -c $S/gdb/gdb_fe.c
SRCS+=$S/gdb/gdb_fe.c
OBJS+=gdb_fe.o

gdb_be.o: $S/gdb/gdb_be.c
	$(CC) $(CFLAGS) -I$S/gdb -c $S/gdb/gdb_be.c
SRCS+=$S/gdb/gdb_be.c
OBJS+=gdb_be.o

DEPINCLUDES+=-I$S/main

main.o: $S/main/main.c
	$(CC) $(CFLAGS) -I$S/main -c $S/main/main.c
SRCS+=$S/main/main.c
OBJS+=main.o

onsel.o: $S/main/onsel.c
	$(CC) $(CFLAGS) -I$S/main -c $S/main/onsel.c
SRCS+=$S/main/onsel.c
OBJS+=onsel.o

clock.o: $S/main/clock.c
	$(CC) $(CFLAGS) -I$S/main -c $S/main/clock.c
SRCS+=$S/main/clock.c
OBJS+=clock.o

console.o: $S/main/console.c
	$(CC) $(CFLAGS) -I$S/main -c $S/main/console.c
SRCS+=$S/main/console.c
OBJS+=console.o

prof.o: $S/main/prof.c
	$(CC) $(CFLAGS) -I$S/main -c $S/main/prof.c
SRCS+=$S/main/prof.c
OBJS+=prof.o

meter.o: $S/main/meter.c
	$(CC) $(CFLAGS) -I$S/main -c $S/main/meter.c
SRCS+=$S/main/meter.c
OBJS+=meter.o

trace.o: $S/main/trace.c
	$(CC) $(CFLAGS) -I$S/main -c $S/main/trace.c
SRCS+=$S/main/trace.c
OBJS+=trace.o

util.o: $S/main/util.c
	$(CC) $(CFLAGS) -I$S/main -c $S/main/util.c
SRCS+=$S/main/util.c
OBJS+=util.o

