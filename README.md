# Brain Surface Mapping Project

This repository contains the tools and data required to convert surface data files between different formats (from FreeSurfer's fsaverage7 to fsaverage6) and map brain surface data to other species' brains using Connectome Workbench.

## Repository Contents

- **_mapped/**: Directory where all the mapped surface data is stored after the conversion and mapping process.
- **data/**: Contains additional data files required for various processing steps.
- **func_gii_files/**: Directory where functional surface data (.func.gii) files are stored.
- **human_surfaces/**: Contains human brain surface files.
- **mgh_files/**: Stores intermediate `.mgh` files, used during the surface data conversion.
- **species_spheres/**: Contains species-specific sphere files used for mapping.
- **species_surfaces/**: Holds species-specific surface files used for overlaying and visualization.
- **surfaceData_matlabs/**: Original MATLAB files containing the brain surface data.
- **README.md**: This file, providing details about the project and how to use the repository.
- **map_cmd.sh**: A shell script that automates the mapping process between species.
- **show_map.py**: A Python script with comments, used to display the mapped surfaces.

## Steps to Map Surfaces

1. **Convert `.mat` file to `.txt`**: 
   Run the `mat_to_freesurfer.py` script to convert the original MATLAB file into `surfaceData.txt`.

2. **Convert `.txt` to `.mgh`**: 
   Use `to_mgh.py` to convert the `surfaceData.txt` file into FreeSurfer's `.mgh` format.

3. **Convert fsaverage7 to fsaverage6**:
   Run the following FreeSurfer command to resample the surface data from fsaverage7 to fsaverage6:
   
   ```bash
   mri_surf2surf --s fsaverage --trgsubject fsaverage6 --hemi lh --sval surfaceData.mgh --tval resampled_surfaceData.mgh
   ```

4. **Convert `.mgh` to `.func.gii`**:
   Convert the `.mgh` file to a functional GIFTI file using the following command:
   
   ```bash
   mri_convert resampled_surfaceData.mgh resampled_surfaceData.func.gii
   ```

5. **Load into Connectome Workbench**:
   Load the left hemisphere inflated surface (`infl_left.surf.gii`) into Connectome Workbench for visualization.

6. **Overlay the Resampled Surface Data**:
   Overlay the `resampled_surfaceData.func.gii` onto the surface in Connectome Workbench.

7. **Map the Resampled Data to Another Species**:
   Use the following command to map the resampled functional surface data from a human brain to another species' brain:
   
   ```bash
   wb_command -metric-resample $FUNC_GII_FILES/resampled_disc_rh.func.gii \
   $SPHERE_DIR/sphere_right.gii $REPO_DIR/_surfaces/sub-046_species-Aplodontia+rufa_hemi-R.sphere.surf.gii \
   ADAP_BARY_AREA ~/sub-046-disc_right.func.gii \
   -area-surfs $SPHERE_DIR/sphere_right.gii $REPO_DIR/_surfaces/sub-046_species-Aplodontia+rufa_hemi-R.sphere.surf.gii
   ```

8. **View Mapped Data**:
   To view the mapped surface data in Connectome Workbench, use the following command:
   
   ```bash
   wb_view $REPO_DIR/_surfaces/sub-028_species-Macaca+mulatta_hemi-L.surf.gii $HOME/output_mapped.func.gii
   ```

## Program Versions

- **FreeSurfer**: v7.3.2
- **Connectome Workbench**: v1.5.0

## Usage

1. Follow the steps outlined in the "Steps to Map Surfaces" section.
2. Use the provided scripts (`map_cmd.sh`, `show_map.py`) for automated processing and visualization of surface data.
3. Refer to the provided `species_spheres/` and `species_surfaces/` directories for the necessary species-specific sphere and surface files.

## License

This project is licensed under the MIT License.
```
