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
