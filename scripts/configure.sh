#!/bin/bash

# Define the base path for the destination
# e.g. /usr/local/codeql-home/codeql-repo/
CODEQL_REPO=$1

# Define the source directory
SOURCE_DIR="/opt/CustomQueries/"

# Get a list of coding language folders in the source directory
LANGUAGES=$(ls "$SOURCE_DIR")

# Loop through each language folder and create the destination directory
for language in $LANGUAGES; do
  for version_dir in "$CODEQL_REPO/qlpacks/codeql/$language-queries/"*; do
    DEST_DIR="$version_dir/Security/CustomQueries"
    
    # Check if the destination directory exists, if not, create it
    mkdir -p "$DEST_DIR"

    echo "$SOURCE_DIR$language"
    echo "$DEST_DIR"
    
    # Move the language folder to the destination
    cp -r "$SOURCE_DIR$language" "$DEST_DIR"
  done
done
