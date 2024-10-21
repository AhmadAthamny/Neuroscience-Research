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

## Final Mapping Steps

For mapping the functional surface data to all target species, we have two main scripts:

### 1. **Resample Functional Data for All Species**  
Run the `resample_all.sh` script to perform the resampling of functional surface data for all target species:

```bash
bash resample_all.sh
```

This will iterate over each species, process both hemispheres, and handle both inflated and discrete surface data. The output is stored in the `_mapped` directory for each species and hemisphere combination.

### 2. **Map Functional Data for All Species and Variants**  
Once resampling is complete, use the `map_all.sh` script to map the resampled functional data:

```bash
bash map_all.sh
```

This command loops through all species and hemispheres (left/right) and processes inflated and discrete data. It maps the data for each combination and stores the results in the appropriate output directories.

## Program Versions

- **FreeSurfer**: v7.3.2
- **Connectome Workbench**: v1.5.0

## Usage

1. Follow the steps outlined in the "Steps to Map Surfaces" section.
2. Use the provided scripts (`resample_all.sh`, `map_all.sh`) for automated processing and mapping of surface data.
3. Refer to the provided `species_spheres/` and `species_surfaces/` directories for the necessary species-specific sphere and surface files.
