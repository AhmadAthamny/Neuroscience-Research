#!/bin/bash

# Species name (replace with the desired species)
species_name="sub-008_species-Mirza+coquereli"  # Set the target species name here

# Directories (adjust paths as needed)
REPO_DIR="/home/ahmed/EvolutionOfCorticalShape"
LABEL_GII_DIR="/home/ahmed/Neuroscience-Research/brain_regions/labels/resampled_2"
OUTPUT_DIR="/home/ahmed/Neuroscience-Research/brain_regions/labels/mapped_2"

# Source species setup (e.g., Homo sapiens)
SOURCE_SPECIES="sub-020_species-Homo+sapiens"

# Check vertex counts for the left hemisphere files
echo "Checking Left Hemisphere Files for ${SOURCE_SPECIES} and target species ${species_name}..."

# 1. Source Sphere
wb_command -file-information "$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-L_topo-Homo.sapiens.sphere.surf.gii"

# 2. Target Sphere for the current species
wb_command -file-information "$REPO_DIR/_surfaces/${species_name}_hemi-L_topo-Homo.sapiens.sphere.reg.surf.gii"

# 3. Model Source Surface
wb_command -file-information "$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-L.surf.gii"

# 4. Model Target Surface for the current species
wb_command -file-information "$REPO_DIR/_surfaces/${species_name}_hemi-L_topo-Homo.sapiens.surf.gii"

echo "Completed vertex count check for Left Hemisphere files."

# Check vertex counts for the right hemisphere files
echo "Checking Right Hemisphere Files for ${SOURCE_SPECIES} and target species ${species_name}..."

# 1. Source Sphere
wb_command -file-information "$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-R_topo-Homo.sapiens.sphere.surf.gii"

# 2. Target Sphere for the current species
wb_command -file-information "$REPO_DIR/_surfaces/${species_name}_hemi-R_topo-Homo.sapiens.sphere.reg.surf.gii"

# 3. Model Source Surface
wb_command -file-information "$REPO_DIR/_surfaces/${SOURCE_SPECIES}_hemi-R.surf.gii"

# 4. Model Target Surface for the current species
wb_command -file-information "$REPO_DIR/_surfaces/${species_name}_hemi-R_topo-Homo.sapiens.surf.gii"

echo "Completed vertex count check for Right Hemisphere files."
