#include <stdio.h>

int ft_nbchar(const char *str, char c);

int main(void)
{
    struct test_case {
        const char *str;
        char c;
        int expected;
    };

    struct test_case tests[] = {
        {"LaTorche brille", 'e', 2},  // Test basique
        {"Hello World", 'l', 3},      // Plusieurs occurrences
        {"42", '2', 1},               // Caractère numérique
        {"", 'a', 0},                 // Chaîne vide
        {" ", ' ', 1},                // Espace seul
        {"\\n", '\n', 0},             // Caractère d'échappement
        {"aaaaa", 'a', 5},            // Tous les caractères identiques
        {"bbbb", 'a', 0},             // Caractère absent
        {NULL, '\0', 0}               // Fin du tableau
    };

    for (int i = 0; tests[i].str != NULL; i++)
    {
        int result = ft_nbchar(tests[i].str, tests[i].c);

        if (result == tests[i].expected)
        {
            printf("Test %d: \033[0;32mOK\033[0m\n", i + 1);
        }
        else
        {
            printf("Test %d: \033[0;31mKO\033[0m\n", i + 1);
            printf("  Chaîne testée : \"%s\"\n", tests[i].str);
            printf("  Caractère     : '%c'\n", tests[i].c);
            printf("  ft_nbchar     : %d\n", result);
            printf("  Résultat attendu : %d\n", tests[i].expected);
        }
    }

    return 0;
}