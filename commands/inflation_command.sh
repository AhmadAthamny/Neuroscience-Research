#!/bin/bash

# Define directories
SURFACES_DIR="species_surfaces"  # Path to your .surf.gii surfaces directory
OUTPUT_DIR="species_surfaces_infl"   # Directory to store the inflated .surf.gii files
TEMP_DIR=$(mktemp -d)            # Temporary directory for intermediate files

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Process each .surf.gii file in the species_surfaces directory
for surf_file in "$SURFACES_DIR"/*.surf.gii; do
    # Extract filename without extension
    filename=$(basename "$surf_file" .surf.gii)
    
    # Define paths for intermediate and output files
    temp_white="$TEMP_DIR/${filename}.white"
    temp_inflated="$TEMP_DIR/${filename}_inflated.white"
    output_inflated="$OUTPUT_DIR/${filename}_inflated.surf.gii"
    
    # Step 1: Convert .surf.gii to .white format for FreeSurfer compatibility
    mris_convert "$surf_file" "$temp_white"
    
    # Step 2: Inflate the surface
    mris_inflate "$temp_white" "$temp_inflated"
    
    # Step 3: Convert inflated .white back to .surf.gii
    mris_convert "$temp_inflated" "$output_inflated"
    
    echo "Inflated surface created: $output_inflated"
done

# Clean up: Remove temporary directory and files
rm -rf "$TEMP_DIR"
echo "Temporary files cleaned up."

echo "All surfaces processed and inflated surfaces saved in $OUTPUT_DIR."
