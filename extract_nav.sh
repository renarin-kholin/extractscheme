#!/bin/bash

# Download the file
curl -s https://www.amfiindia.com/spages/NAVAll.txt -o NAVAll.txt

# Output TSV file
output="nav_data_full.tsv"

# Write header
echo -e "Scheme Code\tISIN Payout/Growth\tISIN Reinvestment\tScheme Name\tNet Asset Value\tDate" > "$output"

# Process each valid line (with 6 fields and numeric Scheme Code)
awk -F ';' '
NF == 6 && $1 ~ /^[0-9]+$/ {
    gsub(/\r/, "", $6);  # Remove carriage return if present
    print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6
}
' NAVAll.txt >> "$output"

echo "Saved extracted data to $output"

