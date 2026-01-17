#!/bin/bash
BOOKS="Books_to_Read.md"
TEMPLATE="README.template"
README="README.md"

# 1. Get Status Counts
R=$(grep -c "| Read |" "$BOOKS")
C=$(grep -c "| Currently Reading |" "$BOOKS")
Y=$(grep -c "| Yet to Start |" "$BOOKS")

# 2. Get Total Books (Counts lines starting with | but skips the header and separator)
TOTAL=$(grep "^|" "$BOOKS" | tail -n +3 | wc -l)

# 3. Fetch a Random Quote from ZenQuotes API
# We use -s for silent and grab just the quote and author
QUOTE_DATA=$(curl -s https://zenquotes.io/api/random)
QUOTE=$(echo $QUOTE_DATA | sed 's/.*"q":"\([^"]*\)".*/\1/')
AUTHOR=$(echo $QUOTE_DATA | sed 's/.*"a":"\([^"]*\)".*/\1/')

# 4. Format the variable for the template
export BOOK_STATS="- ✅ **Read:** $R Books
- 📖 **Currently Reading:** $C Books
- ⏳ **Yet to Start:** $Y Books
- 📚 **Total Books in Library:** $TOTAL"

export QUOTE_OF_DAY="> \"$QUOTE\" — *$AUTHOR* 🏛️"

# 5. Use envsubst to swap BOTH variables
envsubst '$BOOK_STATS $QUOTE_OF_DAY' < "$TEMPLATE" > "$README"

echo "✅ README.md updated with Stats and Internet Quote."
