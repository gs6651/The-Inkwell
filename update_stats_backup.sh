#!/bin/bash
BOOKS="Books_to_Read.md"
TEMPLATE="README.template"
README="README.md"

# 1. Get Counts
R=$(grep -c "| Read |" "$BOOKS")
C=$(grep -c "| Currently Reading |" "$BOOKS")
Y=$(grep -c "| Yet to Start |" "$BOOKS")

# 2. Format the variable for the template
export BOOK_STATS="- ✅ Read: $R Books
- 📖 Currently Reading: $C Books
- ⏳ Yet to Start: $Y Books"

# 3. Use envsubst to create the README from the template
envsubst '$BOOK_STATS' < "$TEMPLATE" > "$README"

echo "✅ README.md updated from template."
