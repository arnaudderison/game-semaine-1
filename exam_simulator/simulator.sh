#!/bin/bash

EXERCISE_DIR="exo"
TEST_DIR=".tests"

# Trouver tous les exercices sous forme ex00, ex01, ..., exN
EXERCISES=($(ls -d $EXERCISE_DIR/ex* 2>/dev/null | grep -oE 'ex[0-9]+' | sort -V))

# Vérifier s'il y a des exercices
if [ ${#EXERCISES[@]} -eq 0 ]; then
    echo "❌ Aucun exercice trouvé dans le dossier $EXERCISE_DIR."
    exit 1
fi

# Trouver le dernier exo en lisant le dernier élément du tableau
LAST_EXO="${EXERCISES[-1]}"


for EXO in "${EXERCISES[@]}"; do
    EXO_PATH="$EXERCISE_DIR/$EXO"
    clear
    echo "📜 Simulation d'examen - Exercices de ${EXERCISES[0]} à $LAST_EXO"
    echo "--------------------------------------------------------"
    if [ -d "$EXO_PATH" ]; then
        echo ""
        echo "🎯 Exercice : $EXO"
        cat "$EXO_PATH/subject.txt"
        echo "✍️  Écrivez votre solution dans le dossier de l'exo."

        read -p "Appuyez sur Entrée pour soumettre votre solution..."

        TEST_SCRIPT="$TEST_DIR/${EXO}/${EXO}_test.sh"

        if [ -f "$TEST_SCRIPT" ]; then
            OUT=$(bash ./$TEST_SCRIPT)
            echo "$OUT"
            if echo "$OUT" | grep -q KO; then
                 echo "" 
                 echo -e "\033[0;31m❌ FAILED : Vous ne pouvez pas passer au prochain niveau \033[0m"
                exit 1
            else
                echo ""
                echo -e "\033[0;32mSUCCESS : Niveau suivant ! \033[0m"
            fi
        else
            echo "⚠️ Aucun test disponible pour cet exercice."
        fi
        read -p "Passer a la correction suivante..."
    fi
done

echo "🎉 Examen terminé !"
