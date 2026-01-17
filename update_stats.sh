#!/bin/bash
BOOKS="Books_to_Read.md"
README="README.md"

# 1. Get Counts
R=$(grep -c "| Read |" "$BOOKS")
C=$(grep -c "| Currently Reading |" "$BOOKS")
Y=$(grep -c "| Yet to Start |" "$BOOKS")

# 2. Extract parts of README
# Everything before the start tag
sed -n '1,//p' "$README" > "$README.new"

# 3. Add the Stats
echo -e "- ✅ Read: $R Books" >> "$README.new"
echo -e "- 📖 Currently Reading: $C Books" >> "$README.new"
echo -e "- ⏳ Yet to Start: $Y Books" >> "$README.new"

# 4. Add the rest of the file
# Everything from the end tag to the bottom
sed -n '//,$p' "$README" >> "$README.new"

# 5. Overwrite
mv "$README.new" "$README"

echo "✅ README.md updated."
