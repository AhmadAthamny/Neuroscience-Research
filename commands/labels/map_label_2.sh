#!/bin/bash

# Directories
REPO_DIR="/home/ahmed/EvolutionOfCorticalShape"
LABEL_GII_DIR="/home/ahmed/Neuroscience-Research/brain_regions/labels/resampled_2/"
OUTPUT_DIR="/home/ahmed/Neuroscience-Research/brain_regions/labels/mapped_2"

# Source species (Homo sapiens)
SOURCE_SPECIES="sub-020_species-Homo+sapiens"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

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

    EXTENSION=".label.gii"

    # Surface data for label GIFTI files
    LABEL_DATA="${species_name}_${HEMISPHERE_UPPER}${EXTENSION}"

    # Source and Target Spheres
    SOURCE_SPHERE="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-${HEMISPHERE_UPPER}_topo-Homo.sapiens.sphere.surf.gii"
    TARGET_SPHERE="$REPO_DIR/_surfaces/${species_name}_hemi-${HEMISPHERE_UPPER}.sphere.surf.gii"
    SPH_RESAMPLE_CPRF="$REPO_DIR/_surfaces/${species_name}_hemi-${HEMISPHERE_UPPER}_topo-Homo.sapiens.sphere.reg.surf.gii"

    # Model Surfaces
    MODEL_SOURCE="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-${HEMISPHERE_UPPER}_topo-Homo.sapiens.sphere.surf.gii"
    MODEL_TARGET="$REPO_DIR/_surfaces/${species_name}_hemi-${HEMISPHERE_UPPER}.sphere.surf.gii"
    MODEL_TARGET_CPRF="$REPO_DIR/_surfaces/${species_name}_hemi-${HEMISPHERE_UPPER}_topo-Homo.sapiens.surf.gii"

    # Output file path for mapped label data
    OUTPUT_FILE="$OUTPUT_DIR/${species_name}_${HEMISPHERE_UPPER}.label.gii"

    # Resample command for label data
    wb_command -label-resample \
        $LABEL_GII_DIR/$LABEL_DATA \
        $SOURCE_SPHERE \
        $SPH_RESAMPLE_CPRF \
        ADAP_BARY_AREA \
        $OUTPUT_FILE \
        -area-surfs $MODEL_TARGET $MODEL_TARGET_CPRF

    echo "Completed mapping for $HEMISPHERE_UPPER hemisphere ($species_name)"
  done
done

echo "Mapping completed for all species."
