#!/bin/bash

# Directories
INPUT_DIR="/home/ahmed/Neuroscience-Research/species_surfaces_topo"  # Folder with topo-Homo.sapiens.surf.gii files
OUTPUT_DIR="/home/ahmed/Neuroscience-Research/species_surfaces_topo/inflated_out"  # Folder to store inflated .gii surfaces
TEMP_DIR="/home/ahmed/Neuroscience-Research/tmp_flder"  # Temporary folder for intermediate files

# Create output and temporary directories if they don't exist
mkdir -p "$OUTPUT_DIR"
mkdir -p "$TEMP_DIR"

# Loop through each topo-Homo.sapiens.surf.gii file in the input directory
for file in "$INPUT_DIR"/*_topo-Homo.sapiens.surf.gii; do
  base_name=$(basename "$file" .surf.gii)
  
  # Step 1: Convert .gii to FreeSurfer .asc format
  mris_convert "$file" "$TEMP_DIR/$base_name.asc"
  
  # Step 2: Inflate the surface (initial inflation)
  mris_inflate "$TEMP_DIR/$base_name.asc" "$TEMP_DIR/${base_name}_inflated.asc"

  # Step 3: Expand the surface further to ensure full visibility of regions
  mris_expand "$TEMP_DIR/${base_name}_inflated.asc" 1.5 "$TEMP_DIR/${base_name}_expanded.asc"  # Adjust the expansion factor as needed
  
  # Step 4: Convert the expanded .asc back to .gii
  mris_convert "$TEMP_DIR/${base_name}_expanded.asc" "$OUTPUT_DIR/${base_name}_inflated.surf.gii"
  
  echo "Fully inflated surface created for $base_name"
done

# Clean up temporary files
rm -r "$TEMP_DIR"

echo "Inflation process completed for all surfaces."