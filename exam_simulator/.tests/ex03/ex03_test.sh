#!/bin/zsh

EXO="ex03"
SOLUTION_FILE="./exo/$EXO/ft_nbchar.c"
EXECUTABLE="solution"

# Chemin vers le binaire à tester
BIN_PATH="./$EXECUTABLE"

# Fonction pour exécuter le test
run_test() {
    # Exécute le binaire et capture la sortie
    OUTPUT=$($BIN_PATH)

    echo "Sortie du programme :"
    echo "$OUTPUT"
    exit 0  # Quitte avec un code de succès
}


# Vérifier si la solution existe
if [ ! -f "$SOLUTION_FILE" ]; then
    echo "❌ KO: Erreur : fichier '$SOLUTION_FILE' introuvable."
    exit 1
fi

# Compiler le fichier
gcc -Wall -Werror -Wextra ./.tests/ex03/tests.c "$SOLUTION_FILE" -o "$EXECUTABLE"
echo $PWD
#2> /dev/null
if [ $? -ne 0 ]; then
    echo "❌ KO: Compilation échouée."
    exit 1
fi

# Vérifier la Norminette
echo "🔍 Vérification Norminette..."
norminette "$SOLUTION_FILE" 1> /dev/null
if [ $? -ne 0 ]; then
    echo "❌ KO: Erreur de Norminette. Corrige le style avant de continuer."
    exit 1
fi
echo "✅ Norminette : OK"

# Vérifier les fuites de mémoire avec Valgrind
echo "🛠️ Vérification avec Valgrind..."
ulimit -n 1048576
valgrind --leak-check=full --error-exitcode=1 "./$EXECUTABLE" > /dev/null 2> valgrind_errors.log
if [ $? -ne 0 ]; then
    echo "❌ KO: Valgrind détecte des fuites de mémoire. Vérifie 'valgrind_errors.log'."
    cat valgrind_errors.log
    exit 1
fi
echo "✅ Valgrind : Pas de fuites mémoire"


# Exécute le test
run_test

# Nettoyage
rm -f "$EXECUTABLE"
