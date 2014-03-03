CC = gcc
CCFLAGS = -Wall

SRC = $(wildcard *.c)

all: blight

blight: $(SRC)
	@echo "CC $@"
	@$(CC) $(CCFLAGS) $(SRC) -o $@

install: blight
	cp blight /usr/local/bin/
	chown root:root /usr/local/bin/blight
	chmod +sx /usr/local/bin/blight

.PHONY: all clean

clean:
	-rm -f blight
