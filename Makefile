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

PREFIX = /usr/local

install: static dynamic
	install -d $(PREFIX)/include $(PREFIX)/lib $(PREFIX)/bin $(PREFIX)/share/man/man3
	install -m 644 include/*.h $(PREFIX)/include
	install -m 644 lib/libmyutils.a $(PREFIX)/lib
	install -m 755 lib/libmyutils.so $(PREFIX)/lib
	install -m 755 bin/client_static $(PREFIX)/bin/client
	install -m 644 man/man3/*.3 $(PREFIX)/share/man/man3
	ldconfig

uninstall:
	rm -f $(PREFIX)/include/mystrfunctions.h $(PREFIX)/include/myfilefunctions.h
	rm -f $(PREFIX)/lib/libmyutils.a $(PREFIX)/lib/libmyutils.so
	rm -f $(PREFIX)/bin/client
	rm -f $(PREFIX)/share/man/man3/*.3
