#!/bin/zsh

EXO="ex01"
SOLUTION_FILE="./exo/$EXO/LaTorche.c"
OUTPUT_FILE="output.txt"
EXECUTABLE="solution"

# Vérifier si la solution existe
if [ ! -f "$SOLUTION_FILE" ]; then
    echo "❌ KO: Erreur : fichier '$SOLUTION_FILE' introuvable."
    exit 1
fi

# Compiler le fichier
gcc -Wall -Werror -Wextra "$SOLUTION_FILE" -o "$EXECUTABLE" 2> /dev/null
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

# Exécuter et capturer la sortie
"./$EXECUTABLE" > "$OUTPUT_FILE"

# Vérifier la sortie
EXPECTED="LaTorche"
RESULT=$(cat "$OUTPUT_FILE")


if [ "$RESULT" == "$EXPECTED" ]; then
    echo "✅ Test réussi ! La sortie est correcte : '$RESULT'"
else
    echo "❌ KO: Test échoué. Sortie attendue : '$EXPECTED', obtenue : '$RESULT'"
fi

# Nettoyage
rm -f "$EXECUTABLE" "$OUTPUT_FILE"
