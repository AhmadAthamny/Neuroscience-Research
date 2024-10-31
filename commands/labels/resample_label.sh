#!/bin/bash

# Directories (Adjust these paths if necessary)
WORK_DIR="/home/ahmed/Neuroscience-Research/brain_regions"
REPO_DIR="/home/ahmed/EvolutionOfCorticalShape"
OUTPUT_DIR="/home/ahmed/Neuroscience-Research/brain_regions/labels/resampled"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Source species (Homo sapiens)
SOURCE_SPECIES="sub-020_species-Homo+sapiens"
SOURCE_SPHERE_L="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-L.sphere.reg.surf.gii"
SOURCE_SPHERE_R="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-R.sphere.reg.surf.gii"
MODEL_SOURCE_L="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-L_midthickness.surf.gii"
MODEL_SOURCE_R="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-R_midthickness.surf.gii"

# Path to the source label data (Adjust if necessary)
LABEL_DATA_L="$WORK_DIR/labels/label_files/LH_result.label.gii"  # Left hemisphere label data
LABEL_DATA_R="$WORK_DIR/labels/label_files/RH_result.label.gii"  # Right hemisphere label data

# Verify that there are files matching the pattern before continuing
species_files=($REPO_DIR/_surfaces/sub-*_hemi-L.sphere.reg.surf.gii)
if [ ${#species_files[@]} -eq 0 ]; then
  echo "No species files found matching pattern $REPO_DIR/_surfaces/sub-*_hemi-L.sphere.reg.surf.gii"
  exit 1
fi

# Iterate over all target species
for species_file in "${species_files[@]}"; do
  # Extract the species name (including sub-XXX prefix)
  species_name=$(basename "$species_file" | cut -d'_' -f1-2)
  echo "Processing species: $species_name"

  # Target spheres and surfaces for the current species (using registered spheres)
  TARGET_SPHERE_L="$REPO_DIR/_surfaces/${species_name}_hemi-L.sphere.reg.surf.gii"
  TARGET_SPHERE_R="$REPO_DIR/_surfaces/${species_name}_hemi-R.sphere.reg.surf.gii"
  MODEL_TARGET_L="$REPO_DIR/_surfaces/${species_name}_hemi-L_midthickness.surf.gii"
  MODEL_TARGET_R="$REPO_DIR/_surfaces/${species_name}_hemi-R_midthickness.surf.gii"

  # Output filenames
  OUTPUT_LH="$OUTPUT_DIR/${species_name}_L.label.gii"
  OUTPUT_RH="$OUTPUT_DIR/${species_name}_R.label.gii"

  # Check if necessary files exist before processing
  if [ -f "$LABEL_DATA_L" ] && [ -f "$SOURCE_SPHERE_L" ] && [ -f "$TARGET_SPHERE_L" ] && [ -f "$MODEL_SOURCE_L" ] && [ -f "$MODEL_TARGET_L" ]; then
    # Resample left hemisphere label data
    wb_command -label-resample \
      "$LABEL_DATA_L" \
      "$SOURCE_SPHERE_L" \
      "$TARGET_SPHERE_L" \
      ADAP_BARY_AREA \
      "$OUTPUT_LH" \
      -area-surfs "$MODEL_SOURCE_L" "$MODEL_TARGET_L"
    echo "Completed left hemisphere mapping for species: $species_name"
  else
    echo "Missing files for left hemisphere processing of $species_name. Skipping..."
  fi

  if [ -f "$LABEL_DATA_R" ] && [ -f "$SOURCE_SPHERE_R" ] && [ -f "$TARGET_SPHERE_R" ] && [ -f "$MODEL_SOURCE_R" ] && [ -f "$MODEL_TARGET_R" ]; then
    # Resample right hemisphere label data
    wb_command -label-resample \
      "$LABEL_DATA_R" \
      "$SOURCE_SPHERE_R" \
      "$TARGET_SPHERE_R" \
      ADAP_BARY_AREA \
      "$OUTPUT_RH" \
      -area-surfs "$MODEL_SOURCE_R" "$MODEL_TARGET_R"
    echo "Completed right hemisphere mapping for species: $species_name"
  else
    echo "Missing files for right hemisphere processing of $species_name. Skipping..."
  fi

done

echo "Mapping completed for all species."
