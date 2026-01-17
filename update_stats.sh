#!/bin/bash
BOOKS="Books_to_Read.md"
README="README.md"

# 1. Get Counts
R=$(grep -c "| Read |" "$BOOKS")
C=$(grep -c "| Currently Reading |" "$BOOKS")
Y=$(grep -c "| Yet to Start |" "$BOOKS")

# 2. Create the Stats
STATS="- ✅ Read: $R Books\n- 📖 Currently Reading: $C Books\n- ⏳ Yet to Start: $Y Books"

# 3. Rebuild the file using a Python one-liner (much cleaner for multi-line)
python3 -c "
import sys
content = open('$README').read()
start_tag = ''
end_tag = ''
try:
    prefix = content.split(start_tag)[0]
    suffix = content.split(end_tag)[1]
    new_content = f'{prefix}{start_tag}\n$STATS\n{end_tag}{suffix}'
    with open('$README', 'w') as f:
        f.write(new_content)
except IndexError:
    print('Tags missing in README')
"
echo "✅ README.md updated."
