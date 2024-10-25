#!/bin/bash

# Directories
REPO_DIR="/home/ahmed/EvolutionOfCorticalShape"
FUNC_GII_DIR="/home/ahmed/Neuroscience-Research/brain_regions/func_gii_files/resampled/S1_A1_V1"
OUTPUT_DIR="/home/ahmed/Neuroscience-Research/brain_regions/_mapped/S1_A1_V1"

# Source species (Homo sapiens)
SOURCE_SPECIES="sub-020_species-Homo+sapiens"

# Loop through all species in the target species directory
for species_file in $REPO_DIR/_surfaces/sub-*_hemi-L_topo-Homo.sapiens.sphere.reg.surf.gii; do
  # Extract the species name (including sub-XXX prefix)
  species_name=$(basename $species_file | cut -d'_' -f1-2)
  echo "Processing species: $species_name"

  # Loop through left and right hemispheres
  for HEMISPHERE in "lh" "rh"; do
    if [[ "$HEMISPHERE" == "lh" ]]; then
        HEMISPHERE_UPPER="L"
    else
        HEMISPHERE_UPPER="R"
    fi

    EXTENSION=".func.gii"

    # Surface data for functional GIFTI files
    SURFACE_DATA="${species_name}_${HEMISPHERE}"

    # Spheres and areas (use uppercase L/R for hemisphere in the filenames)
    SOURCE_SPHERE="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-${HEMISPHERE_UPPER}_topo-Homo.sapiens.sphere.surf.gii"
    TARGET_SPHERE="$REPO_DIR/_surfaces/${species_name}_hemi-${HEMISPHERE_UPPER}.sphere.surf.gii"

    # Area surfaces
    MODEL_SOURCE="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-${HEMISPHERE_UPPER}_topo-Homo.sapiens.sphere.surf.gii"
    MODEL_TARGET="$REPO_DIR/_surfaces/${species_name}_hemi-${HEMISPHERE_UPPER}.sphere.surf.gii"

    # Output file path
    OUTPUT_FILE="$OUTPUT_DIR/${species_name}_${HEMISPHERE}.func.gii"

    # Resample command
    wb_command -metric-resample \
        $FUNC_GII_DIR/$SURFACE_DATA \
        $SOURCE_SPHERE \
        $TARGET_SPHERE \
        ADAP_BARY_AREA \
        $OUTPUT_FILE \
        -area-surfs $MODEL_SOURCE $MODEL_TARGET

    echo "Completed mapping for $HEMISPHERE ($species_name)"
  done
done

echo "Mapping completed for all species."
