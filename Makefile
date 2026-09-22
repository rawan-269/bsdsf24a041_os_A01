CC = gcc
CFLAGS = -Wall -Iinclude
SRC = src/mystrfunctions.c src/myfilefunctions.c src/main.c
OBJ = $(SRC:src/%.c=obj/%.o)
TARGET = bin/client

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET)

obj/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f obj/*.o bin/client
