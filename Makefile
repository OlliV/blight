CC = gcc
CCFLAGS = -Wall
TYPE = INTEL

SRC = $(wildcard *.c)

all: blight

blight: $(SRC)
	@echo "CC $@"
	@$(CC) $(CCFLAGS) -D$(TYPE) $(SRC) -o $@

install: blight
	install -o root -g root -m 6755 blight $(PREFIX)/bin

.PHONY: all clean

clean:
	-rm -f blight
