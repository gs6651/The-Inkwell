#!/bin/bash
BOOKS="Books_to_Read.md"
README="README.md"

# Count statuses
R=$(grep -c "| Read |" "$BOOKS")
C=$(grep -c "| Currently Reading |" "$BOOKS")
Y=$(grep -c "| Yet to Start |" "$BOOKS")

# Create the text block (using \n for newlines)
STATS="- ✅ Read: $R Books\n- 📖 Currently Reading: $C Books\n- ⏳ Yet to Start: $Y Books"

# This version uses a 'marker' to replace everything between the tags in one go
# It is much cleaner and avoids the "previous regular expression" error
sed -i "//,//c\\n$STATS\n" "$README"

echo "✅ README.md updated."
