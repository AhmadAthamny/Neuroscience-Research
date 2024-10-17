# Brain Surface Mapping Project

This repository contains the tools and data required to convert surface data files between different formats (from FreeSurfer's fsaverage7 to fsaverage6) and map brain surface data to other species' brains using Connectome Workbench.

## Repository Contents

- **_mapped**: Directory where all the mapped surface data (left and right hemispheres) is stored after the conversion and mapping process.
- **data**: Contains additional data files required for various processing steps.
- **func_gii_files**: Directory where functional surface data (.func.gii) files (for both left and right hemispheres) are stored.
- **human_surfaces**: Contains human brain surface files for both hemispheres.
- **mgh_files**: Stores intermediate `.mgh` files for both hemispheres, used during the surface data conversion.
- **species_spheres**: Contains species-specific sphere files (for both hemispheres) used for mapping.
- **species_surfaces**: Holds species-specific surface files for both hemispheres, used for overlaying and visualization.
- **surfaceData_matlabs**: Original MATLAB files containing the brain surface data for both hemispheres.
- **README.md**: This file, providing details about the project and how to use the repository.
- **map_cmd.sh**: A shell script that automates the mapping process between species for both hemispheres.
- **show_map.py**: A Python script with comments, used to display the mapped surfaces for both hemispheres.

## Steps to Map Surfaces

1. **Convert `.mat` file to `.txt`**: 
   Run the `mat_to_freesurfer.py` script to convert the original MATLAB file into `surfaceData.txt` (for both hemispheres).

2. **Convert `.txt` to `.mgh`**: 
   Use `to_mgh.py` to convert the `surfaceData.txt` file into FreeSurfer's `.mgh` format (for both hemispheres).

3. **Convert fsaverage7 to fsaverage6**:
   Run the following FreeSurfer command to resample the surface data from fsaverage7 to fsaverage6 (for left and right hemispheres):
   
   ```bash
   mri_surf2surf --s fsaverage --trgsubject fsaverage6 --hemi lh --sval surfaceData.mgh --tval resampled_surfaceData.mgh
   ```

   Repeat the command with `--hemi rh` for the right hemisphere.

4. **Convert `.mgh` to `.func.gii`**:
   Convert the `.mgh` file to a functional GIFTI file using the following command (for both hemispheres):
   
   ```bash
   mri_convert resampled_surfaceData.mgh resampled_surfaceData.func.gii
   ```

5. **Load into Connectome Workbench**:
   Load the left and right hemisphere inflated surfaces (`infl_left.surf.gii` and `infl_right.surf.gii`) into Connectome Workbench for visualization.

6. **Overlay the Resampled Surface Data**:
   Overlay the `resampled_surfaceData.func.gii` onto the surfaces in Connectome Workbench (for both hemispheres).

7. **Map the Resampled Data to Another Species**:
   Use the following command to map the resampled functional surface data from a human brain to another species' brain (for both hemispheres):
   
   ```bash
   wb_command -metric-resample $FUNC_GII_FILES/resampled_disc_rh.func.gii \
   $SPHERE_DIR/sphere_right.gii $REPO_DIR/_surfaces/sub-046_species-Aplodontia+rufa_hemi-R.sphere.surf.gii \
   ADAP_BARY_AREA ~/sub-046-disc_right.func.gii \
   -area-surfs $SPHERE_DIR/sphere_right.gii $REPO_DIR/_surfaces/sub-046_species-Aplodontia+rufa_hemi-R.sphere.surf.gii
   ```

   Repeat the command for the left hemisphere by adjusting the input and output filenames accordingly.

8. **View Mapped Data**:
   To view the mapped surface data in Connectome Workbench for both hemispheres, use the following command:
   
   ```bash
   wb_view $REPO_DIR/_surfaces/sub-028_species-Macaca+mulatta_hemi-L.surf.gii $HOME/output_mapped.func.gii
   ```

   Repeat the command for the right hemisphere.

## Program Versions

- **FreeSurfer**: v7.3.2
- **Connectome Workbench**: v1.5.0

## Usage

1. Follow the steps outlined in the "Steps to Map Surfaces" section.
2. Use the provided scripts (`map_cmd.sh`, `show_map.py`) for automated processing and visualization of surface data for both hemispheres.
3. Refer to the provided `species_spheres/` and `species_surfaces/` directories for the necessary species-specific sphere and surface files for both hemispheres.
