#include <stdio.h>
#include <string.h>
#include "mystrfunctions.h"
#include "myfilefunctions.h"

int main() {
    printf("===== Testing String Functions =====\n");

    char test[] = "hello world";
    printf("Original: %s\n", test);

    char reversed[] = "hello world";
    str_reverse(reversed);
    printf("Reversed: %s\n", reversed);

    char upper[] = "hello world";
    str_to_upper(upper);
    printf("Uppercase: %s\n", upper);

    printf("Word count in 'this is a test': %d\n", str_count_words("this is a test"));

    printf("Is 'level' a palindrome? %s\n", str_is_palindrome("level") ? "Yes" : "No");
    printf("Is 'hello' a palindrome? %s\n", str_is_palindrome("hello") ? "Yes" : "No");

    printf("\n===== Testing File Functions =====\n");

    const char *test_file = "test.txt";
    FILE *fp = fopen(test_file, "w");
    fprintf(fp, "Hello World\nThis is a test file\nHello again\n");
    fclose(fp);

    printf("Word count in file: %d\n", file_count_words(test_file));
    printf("Line count in file: %d\n", file_count_lines(test_file));
    printf("Occurrences of 'Hello': %d\n", file_search_pattern(test_file, "Hello"));

    return 0;
}
