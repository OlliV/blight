CC = gcc
CCFLAGS = -Wall
TYPE = INTEL

SRC = $(wildcard *.c)

all: blight

blight: $(SRC)
	@echo "CC $@"
	@$(CC) $(CCFLAGS) -D$(TYPE) $(SRC) -o $@

install: blight
	cp blight /usr/local/bin/
	chown root:root /usr/local/bin/blight
	chmod +sx /usr/local/bin/blight

.PHONY: all clean

clean:
	-rm -f blight
