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

LIBOBJ = obj/mystrfunctions.o obj/myfilefunctions.o
STATIC_LIB = lib/libmyutils.a
STATIC_TARGET = bin/client_static

static: $(STATIC_TARGET)

$(STATIC_TARGET): $(STATIC_LIB) obj/main.o
	$(CC) obj/main.o -Llib -lmyutils -o $(STATIC_TARGET)

$(STATIC_LIB): $(LIBOBJ)
	ar rcs $(STATIC_LIB) $(LIBOBJ)

DYNAMIC_LIB = lib/libmyutils.so
DYNAMIC_TARGET = bin/client_dynamic

dynamic: $(DYNAMIC_TARGET)

$(DYNAMIC_TARGET): $(DYNAMIC_LIB) src/main.c
	$(CC) $(CFLAGS) src/main.c -Llib -lmyutils -o $(DYNAMIC_TARGET)

$(DYNAMIC_LIB): src/mystrfunctions.c src/myfilefunctions.c
	$(CC) $(CFLAGS) -fPIC -shared -o $(DYNAMIC_LIB) src/mystrfunctions.c src/myfilefunctions.c
