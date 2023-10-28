#!/bin/bash
# Define file paths
SCAN_RESULT="output_files/scan_results.txt"

# Loop through each queue file
for QUEUE_FILE in queue_files/*.txt; do
    # Use grep to filter lines not present in $SCAN_RESULT
    comm -23 <(sort "$QUEUE_FILE") <(sort $SCAN_RESULT) > "$QUEUE_FILE.temp"

    # Replace the original queue file with the filtered one
    mv "$QUEUE_FILE.temp" "$file"
done
