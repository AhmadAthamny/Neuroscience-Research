#!/bin/bash

# Directories
SURFACES_DIR="/home/ahmed/EvolutionOfCorticalShape/_surfaces"
OVERLAYS_DIR="/home/ahmed/Neuroscience-Research/brain_regions/_mapped/S1_A1_V1"
OUTPUT_DIR="/home/ahmed/Neuroscience-Research/brain_regions/screenshots"
WB_COMMAND_PATH="wb_command"  # Update with actual path to wb_command

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Loop through species and hemispheres
for surf_file in $SURFACES_DIR/sub-*_hemi-*.surf.gii; do
    # Extract species name and hemisphere from the filename
    base_name=$(basename "$surf_file")
    species_name=$(echo "$base_name" | cut -d'_' -f1-2)
    hemisphere=$(echo "$base_name" | grep -oP '(?<=hemi-)[LR]')

    # Determine overlay file based on hemisphere
    overlay_file="$OVERLAYS_DIR/${species_name}_${hemisphere}.func.gii"

    # Check if overlay file exists
    if [[ ! -f "$overlay_file" ]]; then
        echo "Overlay file not found for $species_name $hemisphere"
        continue
    fi

    # Define screenshot output path
    screenshot_file="$OUTPUT_DIR/${species_name}_${hemisphere}.png"

    # Display and capture screenshot with wb_command
    $WB_COMMAND_PATH -surface "$surf_file" -overlay-metric "$overlay_file" -screenshot "$screenshot_file"

    echo "Captured screenshot for $species_name $hemisphere: $screenshot_file"
done

echo "Screenshot capture complete for all species and hemispheres."
