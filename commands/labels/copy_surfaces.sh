#!/bin/bash

# Directories
REPO_DIR="/home/ahmed/EvolutionOfCorticalShape/_surfaces"  # Update this to the actual path of the _surfaces folder
OUTPUT_DIR="/home/ahmed/Neuroscience-Research/species_surfaces_topo"  # Folder to store the copied files

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Copy all topo-Homo.sapiens.surf.gii files for both hemispheres
for file in "$REPO_DIR"/*_topo-Homo.sapiens.surf.gii; do
  # Check if the file exists (in case there are no matches)
  if [ -f "$file" ]; then
    cp "$file" "$OUTPUT_DIR/"
    echo "Copied $(basename "$file") to $OUTPUT_DIR."
  fi
done

echo "All topo-Homo.sapiens.surf.gii files copied to $OUTPUT_DIR."
