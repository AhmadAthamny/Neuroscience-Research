#!/bin/bash

# Define paths inside the script
REPO_DIR="/home/ahmed/EvolutionOfCorticalShape"     # Adjust to your actual path to the repository
HOME_DIR="/home/ahmed"                             # Your home directory
DEST_DIR="$HOME_DIR/WorkDirectory/all_surfaces"    # Directory where you want to collect .surf.gii files

# Create destination directory if it doesn't exist
mkdir -p $DEST_DIR

# Find and copy only files that end with .surf.gii (exactly) to the destination directory
find $REPO_DIR/_surfaces -type f -name "*.surf.gii" ! -name "*.*.surf.gii" -exec cp {} $DEST_DIR \;

# Notify that the operation is complete
echo "All .surf.gii files have been collected in $DEST_DIR (only exact matches)"
