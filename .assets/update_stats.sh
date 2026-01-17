#!/bin/bash
# Paths - Using absolute paths or relative to the script location is safest
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INK_BOOKS="$DIR/../Books_to_Read.md"
INK_TEMPLATE="$DIR/readme-template.txt"
INK_README="$DIR/../README.md"

PROF_TEMPLATE="$HOME/Documents/GitLocal/gs6651/.assets/readme-template.txt"
PROF_README="$HOME/Documents/GitLocal/gs6651/README.md"

# 1. Get Stats
R=$(grep -c "| Read |" "$INK_BOOKS")
C=$(grep -c "| Currently Reading |" "$INK_BOOKS")
Y=$(grep -c "| Yet to Start |" "$INK_BOOKS")
TOTAL=$(grep "^|" "$INK_BOOKS" | tail -n +3 | wc -l)

# 2. Fetch Quote
QUOTE_DATA=$(curl -s --max-time 5 https://zenquotes.io/api/random)
if [ $? -eq 0 ] && [ -n "$QUOTE_DATA" ]; then
    QUOTE=$(echo "$QUOTE_DATA" | sed 's/.*"q":"\([^"]*\)".*/\1/')
    AUTHOR=$(echo "$QUOTE_DATA" | sed 's/.*"a":"\([^"]*\)".*/\1/')
else
    QUOTE="The journey of a thousand miles begins with a single step."
    AUTHOR="Lao Tzu"
fi

# 3. Export for envsubst
export BOOK_STATS="- ✅ **Read:** $R Books
- 📖 **Currently Reading:** $C Books
- ⏳ **Yet to Start:** $Y Books
- 📚 **Total Books:** $TOTAL"

export QUOTE_OF_DAY="> \"$QUOTE\" — *$AUTHOR* 🏛️"

# 4. Generate READMEs
envsubst '$BOOK_STATS $QUOTE_OF_DAY' < "$INK_TEMPLATE" > "$INK_README"
if [ -f "$PROF_TEMPLATE" ]; then
    envsubst '$BOOK_STATS' < "$PROF_TEMPLATE" > "$PROF_README"
fi

echo "✅ All READMEs regenerated."
