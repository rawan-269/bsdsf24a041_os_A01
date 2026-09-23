# OS Assignment 01 - Report

## Feature 2: Multi-file Build

### Q1: Makefile linking rules vs library linking
In the multi-file build, the Makefile compiles each .c file into a separate
.o (object) file, then links all the object files directly together into
one executable using gcc. There is no library involved — the linker just
combines the object files' machine code directly.

Library linking (used in later features) is different: instead of linking
object files directly, the executable links against a library file
(.a or .so) using the -l flag, and the linker pulls in only the needed
functions from that library.

### Q2: Git tags - simple vs annotated
A simple tag (git tag v1) is just a lightweight pointer to a specific
commit - it stores no extra information.

An annotated tag (git tag -a v1 -m "message") is a full Git object that
stores the tagger's name, email, date, and a message. Annotated tags are
recommended for releases because they carry more metadata and can be
verified/signed.

### Q3: GitHub releases and binary distribution
GitHub releases let you package a specific tagged version of the project
along with compiled binaries (executables) attached as downloadable
assets. This lets users download and run the program directly without
needing to clone the repository and compile it themselves.

## Feature 4: Dynamic Library

### Q1: Position-Independent Code (PIC) requirements
Shared libraries (.so files) can be loaded into different processes at
different memory addresses, and multiple programs may load the same
library simultaneously at different locations in their own address
space. PIC (compiled with -fPIC) generates code that uses relative
addressing instead of absolute memory addresses, so the code works
correctly no matter where it ends up in memory. Static libraries don't
need this because their code is copied directly into one fixed
executable at link time.

### Q2: Executable size differences
In this project, client_static and client_dynamic came out to
approximately the same size (17K), because the custom library
(libmyutils) itself is very small - only two modules with a handful
of functions. The size advantage of dynamic linking becomes much more
noticeable with larger libraries, where static linking would copy a
large amount of code into every executable, while dynamic linking
lets multiple programs share one copy of the library code in memory
and keeps each executable smaller.

### Q3: LD_LIBRARY_PATH and the dynamic loader
LD_LIBRARY_PATH is an environment variable that tells the dynamic
linker (ld.so) additional directories to search for shared libraries
at program startup, before checking the default system directories
(/lib, /usr/lib). Without it, running client_dynamic failed with
"cannot open shared object file" because libmyutils.so was not in a
directory the loader searches by default. Setting
LD_LIBRARY_PATH=$PWD/lib let the loader find it in our local lib/
folder. The ldd command can be used to verify which shared libraries
an executable depends on and where they were resolved from.
