#!/bin/bash

# Download NAVAll.txt
curl -s https://www.amfiindia.com/spages/NAVAll.txt -o NAVAll.txt

# Output file
output="nav_data.json"

# Begin JSON array
echo "[" > "$output"

# Extract and format valid data lines
awk -F ';' '
NF == 6 && $1 ~ /^[0-9]+$/ {
    gsub(/\r/, "", $6); # Remove carriage return
    printf "  {\n"
    printf "    \"Scheme Code\": \"%s\",\n", $1
    printf "    \"ISIN Payout/Growth\": \"%s\",\n", $2
    printf "    \"ISIN Reinvestment\": \"%s\",\n", $3
    printf "    \"Scheme Name\": \"%s\",\n", $4
    printf "    \"Net Asset Value\": \"%s\",\n", $5
    printf "    \"Date\": \"%s\"\n", $6
    printf "  },\n"
}
' NAVAll.txt >> "$output"

# Remove trailing comma from last JSON object and close array
sed -i '$ s/},/}/' "$output"
echo "]" >> "$output"

echo "Saved JSON to $output"
