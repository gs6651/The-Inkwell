#!/bin/bash

# Path to your files
BOOKS_FILE="Books_to_Read.md"
README_FILE="README.md"

# Count the occurrences in the "Status" column
READ_COUNT=$(grep -c "| Read |" "$BOOKS_FILE")
CURRENT_COUNT=$(grep -c "| Currently Reading |" "$BOOKS_FILE")
YET_COUNT=$(grep -c "| Yet to Start |" "$BOOKS_FILE")

# Prepare the new stats block (using simple text)
STATS_BLOCK="- ✅ Read: $READ_COUNT Books\n- 📖 Currently Reading: $CURRENT_COUNT Books\n- ⏳ Yet to Start: $YET_COUNT Books"

# Use a simpler sed approach to replace content between tags
# This deletes everything between the tags and then adds the new block
sed -i '//,// {
    //! { //!d; }
}' "$README_FILE"

sed -i "//a $STATS_BLOCK" "$README_FILE"

echo "✅ README.md updated with latest book stats."
