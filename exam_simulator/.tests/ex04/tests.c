#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

void ft_revstr(const char *str);

void capture_output(const char *str, char *output, size_t output_size)
{
    int pipefd[2];
    pipe(pipefd);

    int saved_stdout = dup(STDOUT_FILENO);
    dup2(pipefd[1], STDOUT_FILENO);
    close(pipefd[1]);

    ft_revstr(str);
    fflush(stdout);

    dup2(saved_stdout, STDOUT_FILENO);
    close(saved_stdout);

    ssize_t bytes_read = read(pipefd[0], output, output_size - 1);
    close(pipefd[0]);
    
    if (bytes_read >= 0)
        output[bytes_read] = '\0';
    else
        output[0] = '\0';
}

int main(void)
{
    struct test_case {
        const char *original;
        const char *expected;
    };

    struct test_case tests[] = {
        {"hello", "olleh"},
        {"42", "24"},
        {"a", "a"},
        {"ab", "ba"},
        {"LaTorche", "ehcroTaL"},
        {"12345", "54321"},
        {NULL, NULL}
    };

    for (int i = 0; tests[i].original != NULL; i++)
    {
        char output[100] = {0};
        capture_output(tests[i].original, output, sizeof(output));

        size_t len = strlen(output);
        if (len > 0 && output[len - 1] == '\n')
            output[len - 1] = '\0';

        if (!strcmp(output, tests[i].expected) == 0)
        {
            printf("❌ \033[0;31mKO\033[0m\n");
            exit(1);
        }
        
    }
    printf("✅: OK\n");
    return 0;
}