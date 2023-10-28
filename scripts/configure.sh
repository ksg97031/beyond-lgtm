#!/bin/bash

# Define the source directory
SOURCE_DIR="CustomQueries/"

# Get a list of coding language folders in the source directory
LANGUAGES=$(ls "$SOURCE_DIR")

# Define the base path for the destination
BASE_DEST="/usr/local/codeql-home/codeql-repo/"

# Loop through each language folder and create the destination directory
for language in $LANGUAGES; do
  DEST_DIR="$BASE_DEST$language/ql/src/Security/CustomQueries"
  mkdir -p "$DEST_DIR"

  # Copy files from the source directory to the destination
  cp "$SOURCE_DIR$language"/* "$DEST_DIR" >> "$LOG_FILE" 2>&1
done
