#!/bin/bash

# Directories
REPO_DIR="/home/ahmed/EvolutionOfCorticalShape"
OUTPUT_DIR="/home/ahmed/Neuroscience-Research/brain_regions/labels/resampled_2"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Source species setup (e.g., Homo sapiens)
SOURCE_SPECIES="sub-020_species-Homo+sapiens"
SOURCE_SPHERE_L="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-L_topo-Homo.sapiens.sphere.reg.surf.gii"
SOURCE_SPHERE_R="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-R_topo-Homo.sapiens.sphere.reg.surf.gii"
MODEL_SOURCE_L="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-L.surf.gii"
MODEL_SOURCE_R="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-R.surf.gii"

# Path to source label data
LABEL_DATA_L="/home/ahmed/Neuroscience-Research/brain_regions/labels/label_files/LH_result.label.gii"
LABEL_DATA_R="/home/ahmed/Neuroscience-Research/brain_regions/labels/label_files/RH_result.label.gii"

# Loop through each target species
for species_file in $REPO_DIR/_surfaces/sub-*_hemi-L_topo-Homo.sapiens.sphere.reg.surf.gii; do
  # Extract species name
  species_name=$(basename "$species_file" | cut -d'_' -f1-2)
  echo "Processing species: $species_name"

  # Define target sphere and model surfaces based on GitHub example structure
  TARGET_SPHERE_L="$REPO_DIR/_surfaces/${species_name}_hemi-L.sphere.surf.gii"
  TARGET_SPHERE_R="$REPO_DIR/_surfaces/${species_name}_hemi-R.sphere.surf.gii"
  MODEL_TARGET_L="$REPO_DIR/_surfaces/${species_name}_hemi-L.surf.gii"
  MODEL_TARGET_R="$REPO_DIR/_surfaces/${species_name}_hemi-R.surf.gii"

  # Define the output filenames
  OUTPUT_LH="$OUTPUT_DIR/${species_name}_L.label.gii"
  OUTPUT_RH="$OUTPUT_DIR/${species_name}_R.label.gii"

  # Check for necessary files before processing
  if [ -f "$LABEL_DATA_L" ] && [ -f "$SOURCE_SPHERE_L" ] && [ -f "$TARGET_SPHERE_L" ] && [ -f "$MODEL_SOURCE_L" ] && [ -f "$MODEL_TARGET_L" ]; then
    # Resample left hemisphere
    wb_command -label-resample \
      "$LABEL_DATA_L" \
      "$SOURCE_SPHERE_L" \
      "$TARGET_SPHERE_L" \
      ADAP_BARY_AREA \
      "$OUTPUT_LH" \
      -area-surfs "$MODEL_SOURCE_L" "$MODEL_TARGET_L"
    echo "Completed resampling for left hemisphere: $species_name"
  else
    echo "Missing files for left hemisphere of $species_name. Skipping..."
  fi

  if [ -f "$LABEL_DATA_R" ] && [ -f "$SOURCE_SPHERE_R" ] && [ -f "$TARGET_SPHERE_R" ] && [ -f "$MODEL_SOURCE_R" ] && [ -f "$MODEL_TARGET_R" ]; then
    # Resample right hemisphere
    wb_command -label-resample \
      "$LABEL_DATA_R" \
      "$SOURCE_SPHERE_R" \
      "$TARGET_SPHERE_R" \
      ADAP_BARY_AREA \
      "$OUTPUT_RH" \
      -area-surfs "$MODEL_SOURCE_R" "$MODEL_TARGET_R"
    echo "Completed resampling for right hemisphere: $species_name"
  else
    echo "Missing files for right hemisphere of $species_name. Skipping..."
  fi

done

echo "Resampling process completed for all species."
