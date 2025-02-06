#include <stdio.h>
#include <string.h>

int	ft_strlen(const char *str);

int main(void)
{
    // Tableau de chaînes de test
    const char *test_strings[] = {
        "LaTorche",
        "",
        "Hello World",
        "42",
        " ",
        "\\n",
        NULL
    };

    for (int i = 0; test_strings[i] != NULL; i++)
    {
        size_t ft_len = ft_strlen(test_strings[i]);

        size_t std_len = strlen(test_strings[i]);

        if (ft_len == std_len)
            printf("\033[0;32mOK:\033[0m Test %d \n", i + 1);
        else
        {
            printf("Test %d: \033[0;31mKO\033[0m\n", i + 1);
            printf("  Chaîne testée : \"%s\"\n", test_strings[i]);
            printf("  ft_strlen : %zu\n", ft_len);
            printf("  strlen    : %zu\n", std_len);
        }
    }

    return 0;
}