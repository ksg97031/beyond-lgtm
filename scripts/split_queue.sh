#!/bin/bash
# Check if the "queue" directory exists and is not empty
if [ -n "$(ls -A queue 2>/dev/null)" ]; then
  echo "Contains Queue Files"
else
  echo "Empty (or does not exist)"
fi

# Define the default size
size=30

# Check if a size argument was provided
if [ ! "$#" -eq 0 ]; then
  size=$1
fi

echo "Size is $size"

# Choose a random file from the "queue" directory
file_to_process=$(ls queue/*.txt | shuf -n 1)

# Extract the first 'size' lines from the selected file to create "output_files/scan_targets.txt"
head -n $size "$file_to_process" > output_files/scan_targets.txt

# Remove the first 'size' lines from the original file
next=$(($size + 1))
tail -n +$next "$file_to_process" > "$file_to_process.tmp"
mv "$file_to_process.tmp" "$file_to_process"

# Remove the original file if it's empty
if [ ! -s "$file_to_process" ]; then
  rm "$file_to_process"
fi
