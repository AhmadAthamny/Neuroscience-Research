#!/bin/bash

# Directories
INPUT_DIR="/home/ahmed/Neuroscience-Research/species_surfaces_topo"  # Folder with topo-Homo.sapiens.surf.gii files
OUTPUT_DIR="/home/ahmed/Neuroscience-Research/species_surfaces_topo/inflated"  # Folder to store inflated .gii surfaces
TEMP_DIR="/home/ahmed/Neuroscience-Research/temp_files"  # Temporary folder for intermediate files

# Create output and temporary directories if they don't exist
mkdir -p "$OUTPUT_DIR"
mkdir -p "$TEMP_DIR"

# Loop through each topo-Homo.sapiens.surf.gii file in the input directory
for file in "$INPUT_DIR"/*_topo-Homo.sapiens.surf.gii; do
  base_name=$(basename "$file" .surf.gii)
  
  # Step 1: Convert .gii to FreeSurfer .asc format
  mris_convert "$file" "$TEMP_DIR/$base_name.asc"
  
  # Step 2: Inflate the surface
  mris_inflate "$TEMP_DIR/$base_name.asc" "$TEMP_DIR/${base_name}_inflated.asc"
  
  # Step 3: Convert the inflated .asc back to .gii
  mris_convert "$TEMP_DIR/${base_name}_inflated.asc" "$OUTPUT_DIR/${base_name}_inflated.surf.gii"
  
  echo "Inflated surface created for $base_name"
done

# Clean up temporary files
rm -r "$TEMP_DIR"

echo "Inflation process completed for all surfaces."
