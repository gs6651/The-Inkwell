#!/bin/bash
BOOKS="Books_to_Read.md"
TEMPLATE=".README.template"
README="README.md"
PROFILE_README="$HOME/Documents/GitLocal/gs6651/README.md"

# 1. Get Status Counts
R=$(grep -c "| Read |" "$BOOKS")
C=$(grep -c "| Currently Reading |" "$BOOKS")
Y=$(grep -c "| Yet to Start |" "$BOOKS")
TOTAL=$(grep "^|" "$BOOKS" | tail -n +3 | wc -l)

# 2. Fetch Quote
QUOTE_DATA=$(curl -s --max-time 5 https://zenquotes.io/api/random)
if [ $? -eq 0 ] && [ -n "$QUOTE_DATA" ]; then
    QUOTE=$(echo $QUOTE_DATA | sed 's/.*"q":"\([^"]*\)".*/\1/')
    AUTHOR=$(echo $QUOTE_DATA | sed 's/.*"a":"\([^"]*\)".*/\1/')
else
    QUOTE="The journey of a thousand miles begins with a single step."
    AUTHOR="Lao Tzu"
fi

# 3. Format variables
export BOOK_STATS="- ✅ **Read:** $R Books
- 📖 **Currently Reading:** $C Books
- ⏳ **Yet to Start:** $Y Books
- 📚 **Total Books:** $TOTAL"

export QUOTE_OF_DAY="> \"$QUOTE\" — *$AUTHOR* 🏛️"

# 4. Update Inkwell README
envsubst '$BOOK_STATS $QUOTE_OF_DAY' < "$TEMPLATE" > "$README"

# 5. Mirror to Profile README (using the same awk logic we perfected)
if [ -f "$PROFILE_README" ]; then
    awk -v stats="$BOOK_STATS" '
      // { print $0; print stats; skip=1; next }
      // { skip=0 }
      !skip { print }
    ' "$PROFILE_README" > profile.tmp && mv profile.tmp "$PROFILE_README"
fi

echo "✅ All READMEs updated."
