#include <stdio.h>
#include <string.h>
#include "myfilefunctions.h"

int file_count_words(const char *filename) {
    FILE *fp = fopen(filename, "r");
    if (fp == NULL) {
        printf("Error: could not open file %s\n", filename);
        return -1;
    }

    int count = 0, in_word = 0;
    int c;
    while ((c = fgetc(fp)) != EOF) {
        if (c == ' ' || c == '\n' || c == '\t') {
            in_word = 0;
        } else if (!in_word) {
            in_word = 1;
            count++;
        }
    }

    fclose(fp);
    return count;
}

int file_search_pattern(const char *filename, const char *pattern) {
    FILE *fp = fopen(filename, "r");
    if (fp == NULL) {
        printf("Error: could not open file %s\n", filename);
        return -1;
    }

    char line[1024];
    int match_count = 0;

    while (fgets(line, sizeof(line), fp) != NULL) {
        if (strstr(line, pattern) != NULL) {
            match_count++;
        }
    }

    fclose(fp);
    return match_count;
}

int file_count_lines(const char *filename) {
    FILE *fp = fopen(filename, "r");
    if (fp == NULL) {
        printf("Error: could not open file %s\n", filename);
        return -1;
    }

    int count = 0;
    char line[1024];

    while (fgets(line, sizeof(line), fp) != NULL) {
        count++;
    }

    fclose(fp);
    return count;
}
