#!/bin/bash

# Set directories
WORK_DIR="/home/ahmed/WorkDirectory"
REPO_DIR="/home/ahmed/EvolutionOfCorticalShape"
OUTPUT_DIR="/home/ahmed/Neuroscience-Research/species_func_gii"

# Set the source species (Homo sapiens)
SOURCE_SPECIES="sub-020_species-Homo+sapiens"
SOURCE_SPHERE_L="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-L_topo-Homo.sapiens.sphere.reg.surf.gii"
SOURCE_SPHERE_R="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-R_topo-Homo.sapiens.sphere.reg.surf.gii"
MODEL_SOURCE_L="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-L.surf.gii"
MODEL_SOURCE_R="$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-R.surf.gii"

# Iterate over all species in the target species directory
for species_file in $REPO_DIR/_surfaces/sub-*_hemi-L_topo-Homo.sapiens.sphere.reg.surf.gii; do
  # Extract the species name (including sub-XXX prefix)
  species_name=$(basename $species_file | cut -d'_' -f1-2)
  echo "Processing species: $species_name"

  # Set target spheres and surfaces for the current species
  TARGET_SPHERE_L="$REPO_DIR/_surfaces/${species_name}_hemi-L_topo-Homo.sapiens.sphere.reg.surf.gii"
  TARGET_SPHERE_R="$REPO_DIR/_surfaces/${species_name}_hemi-R_topo-Homo.sapiens.sphere.reg.surf.gii"
  MODEL_TARGET_L="$REPO_DIR/_surfaces/${species_name}_hemi-L_topo-Homo.sapiens.surf.gii"
  MODEL_TARGET_R="$REPO_DIR/_surfaces/${species_name}_hemi-R_topo-Homo.sapiens.surf.gii"

  # Define the output filenames for each variant
  OUTPUT_LH_INFL="$OUTPUT_DIR/infl_lh/${species_name}_lh_infl_mapped.func.gii"
  OUTPUT_RH_INFL="$OUTPUT_DIR/infl_rh/${species_name}_rh_infl_mapped.func.gii"
  OUTPUT_LH_DISC="$OUTPUT_DIR/disc_lh/${species_name}_lh_disc_mapped.func.gii"
  OUTPUT_RH_DISC="$OUTPUT_DIR/disc_rh/${species_name}_rh_disc_mapped.func.gii"

  # Perform resampling for inflated left hemisphere
  RESAMPLED_DATA="$WORK_DIR/func_gii_files/resampled_infl_lh.func.gii"
  wb_command -metric-resample $RESAMPLED_DATA $SOURCE_SPHERE_L $TARGET_SPHERE_L ADAP_BARY_AREA $OUTPUT_LH_INFL -area-surfs $MODEL_SOURCE_L $MODEL_TARGET_L

  # Perform resampling for inflated right hemisphere
  RESAMPLED_DATA="$WORK_DIR/func_gii_files/resampled_infl_rh.func.gii"
  wb_command -metric-resample $RESAMPLED_DATA $SOURCE_SPHERE_R $TARGET_SPHERE_R ADAP_BARY_AREA $OUTPUT_RH_INFL -area-surfs $MODEL_SOURCE_R $MODEL_TARGET_R

  # Perform resampling for discrete left hemisphere
  RESAMPLED_DATA="$WORK_DIR/func_gii_files/resampled_disc_lh.func.gii"
  wb_command -metric-resample $RESAMPLED_DATA $SOURCE_SPHERE_L $TARGET_SPHERE_L ADAP_BARY_AREA $OUTPUT_LH_DISC -area-surfs $MODEL_SOURCE_L $MODEL_TARGET_L

  # Perform resampling for discrete right hemisphere
  RESAMPLED_DATA="$WORK_DIR/func_gii_files/resampled_disc_rh.func.gii"
  wb_command -metric-resample $RESAMPLED_DATA $SOURCE_SPHERE_R $TARGET_SPHERE_R ADAP_BARY_AREA $OUTPUT_RH_DISC -area-surfs $MODEL_SOURCE_R $MODEL_TARGET_R

  echo "Completed mapping for species: $species_name"

done

echo "Mapping completed for all species."
