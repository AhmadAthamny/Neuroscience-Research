#!/bin/bash

# Set the variables if they are not globally set
FUNC_GII_FILES="/home/ahmed/WorkDirectory/func_gii_files"
SPHERE_DIR="/home/ahmed/WorkDirectory/spheres"
REPO_DIR="/home/ahmed/EvolutionOfCorticalShape"

# Output directory (specific to this script)
OUTPUT_DIR="$HOME/WorkDirectory/_mapped"

# Debugging: Check paths
echo "FUNC_GII_FILES = $FUNC_GII_FILES"
echo "SPHERE_DIR = $SPHERE_DIR"
echo "REPO_DIR = $REPO_DIR"

# Create necessary output directories
mkdir -p $OUTPUT_DIR/disc_lh $OUTPUT_DIR/disc_rh $OUTPUT_DIR/infl_lh $OUTPUT_DIR/infl_rh

# Loop through all species
for species_surf in $REPO_DIR/_surfaces/*_hemi-L.surf.gii; do
  # Extract species name from file path
  species_name=$(basename $species_surf | sed 's/_hemi-L.surf.gii//')

  # Debugging: Check species name and paths
  echo "Mapping for species: $species_name"
  echo "Left hemisphere surface: $REPO_DIR/_surfaces/${species_name}_hemi-L.sphere.surf.gii"
  echo "Right hemisphere surface: $REPO_DIR/_surfaces/${species_name}_hemi-R.sphere.surf.gii"

  # Left hemisphere discrete mapping
  echo "Mapping left hemisphere discrete data to $species_name..."
  wb_command -metric-resample $FUNC_GII_FILES/resampled_disc_lh.func.gii \
    $SPHERE_DIR/sphere_left.gii \
    $REPO_DIR/_surfaces/${species_name}_hemi-L.sphere.surf.gii \
    ADAP_BARY_AREA $OUTPUT_DIR/disc_lh/${species_name}_lh.func.gii \
    -area-surfs $SPHERE_DIR/sphere_left.gii \
    $REPO_DIR/_surfaces/${species_name}_hemi-L.sphere.surf.gii

  # Right hemisphere discrete mapping
  echo "Mapping right hemisphere discrete data to $species_name..."
  wb_command -metric-resample $FUNC_GII_FILES/resampled_disc_rh.func.gii \
    $SPHERE_DIR/sphere_right.gii \
    $REPO_DIR/_surfaces/${species_name}_hemi-R.sphere.surf.gii \
    ADAP_BARY_AREA $OUTPUT_DIR/disc_rh/${species_name}_rh.func.gii \
    -area-surfs $SPHERE_DIR/sphere_right.gii \
    $REPO_DIR/_surfaces/${species_name}_hemi-R.sphere.surf.gii

  # Left hemisphere inflated mapping
  echo "Mapping left hemisphere inflated data to $species_name..."
  wb_command -metric-resample $FUNC_GII_FILES/resampled_infl_lh.func.gii \
    $SPHERE_DIR/sphere_left.gii \
    $REPO_DIR/_surfaces/${species_name}_hemi-L.sphere.surf.gii \
    ADAP_BARY_AREA $OUTPUT_DIR/infl_lh/${species_name}_lh.func.gii \
    -area-surfs $SPHERE_DIR/sphere_left.gii \
    $REPO_DIR/_surfaces/${species_name}_hemi-L.sphere.surf.gii

  # Right hemisphere inflated mapping
  echo "Mapping right hemisphere inflated data to $species_name..."
  wb_command -metric-resample $FUNC_GII_FILES/resampled_infl_rh.func.gii \
    $SPHERE_DIR/sphere_right.gii \
    $REPO_DIR/_surfaces/${species_name}_hemi-R.sphere.surf.gii \
    ADAP_BARY_AREA $OUTPUT_DIR/infl_rh/${species_name}_rh.func.gii \
    -area-surfs $SPHERE_DIR/sphere_right.gii \
    $REPO_DIR/_surfaces/${species_name}_hemi-R.sphere.surf.gii
done

echo "Mapping completed for all species!"
