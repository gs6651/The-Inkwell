#!/bin/bash
BOOKS="Books_to_Read.md"
README="README.md"

# Count statuses
R=$(grep -c "| Read |" "$BOOKS")
C=$(grep -c "| Currently Reading |" "$BOOKS")
Y=$(grep -c "| Yet to Start |" "$BOOKS")

# Create the stats block
STATS="- ✅ Read: $R Books\n- 📖 Currently Reading: $C Books\n- ⏳ Yet to Start: $Y Books"

# Use awk to swap the content between the tags safely
awk -v stats="$STATS" '
  // {
    print $0
    print stats
    skip=1
  }
  // {
    skip=0
  }
  !skip {
    print $0
  }
' "$README" > README.tmp && mv README.tmp "$README"

echo "✅ README.md updated."
