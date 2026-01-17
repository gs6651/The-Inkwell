#!/bin/bash
BOOKS="Books_to_Read.md"
README="README.md"

# Count statuses
R=$(grep -c "| Read |" "$BOOKS")
C=$(grep -c "| Currently Reading |" "$BOOKS")
Y=$(grep -c "| Yet to Start |" "$BOOKS")

# Create the text block
STATS="- ✅ Read: $R Books\n- 📖 Currently Reading: $C Books\n- ⏳ Yet to Start: $Y Books"

# Update README between tags
sed -i '//,// { //! { //!d; } }' "$README"
sed -i "//a $STATS" "$README"

echo "✅ README.md updated."
