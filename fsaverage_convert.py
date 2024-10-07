import scipy.io as sio
import numpy as np
from nilearn import datasets, surface
from scipy.interpolate import griddata

# Load fsaverage6 surface template
fsaverage6 = datasets.fetch_surf_fsaverage('fsaverage6')

# Fetch fsaverage (full resolution) surface template
fsaverage = datasets.fetch_surf_fsaverage('fsaverage')

# Function to resample surface data from fsaverage to fsaverage6 using the given surface
def resample_and_save(input_file_path, hemisphere, surface_type, output_file_path):
    # Load the data from the .mat file
    data = sio.loadmat(input_file_path)['data'].squeeze()

    # Select the correct surface based on the hemisphere and surface type
    if hemisphere == 'left':
        if surface_type == 'pial':
            fsaverage_mesh = fsaverage['pial_left']
            fsaverage6_mesh = fsaverage6['pial_left']
        elif surface_type == 'inflated':
            fsaverage_mesh = fsaverage['infl_left']
            fsaverage6_mesh = fsaverage6['infl_left']
    elif hemisphere == 'right':
        if surface_type == 'pial':
            fsaverage_mesh = fsaverage['pial_right']
            fsaverage6_mesh = fsaverage6['pial_right']
        elif surface_type == 'inflated':
            fsaverage_mesh = fsaverage['infl_right']
            fsaverage6_mesh = fsaverage6['infl_right']

    # Get the vertex coordinates for fsaverage and fsaverage6
    fsaverage_coords, _ = surface.load_surf_mesh(fsaverage_mesh)
    fsaverage6_coords, _ = surface.load_surf_mesh(fsaverage6_mesh)

    # Use griddata to interpolate the data from fsaverage to fsaverage6
    resampled_data = griddata(fsaverage_coords, data, fsaverage6_coords, method='linear')

    # Save the resampled data to a new .mat file
    sio.savemat(output_file_path, {'data': resampled_data})
    print(f"Resampled data saved to {output_file_path}")

# File paths of the uploaded files
lh_400_path = 'Matlabs/body_lh_400.mat'
rh_400_path = 'Matlabs/body_rh_400.mat'
disc_lh_path = 'Matlabs/body_disc_lh.mat'
disc_rh_path = 'Matlabs/body_disc_rh.mat'

# Convert the inflated files (lh_400, rh_400) to fsaverage6 using the inflated surfaces
resample_and_save(lh_400_path, 'left', 'inflated', 'Matlabs/body_lh_400_fsaverage6_inflated.mat')
resample_and_save(rh_400_path, 'right', 'inflated', 'Matlabs/body_rh_400_fsaverage6_inflated.mat')

# Convert the discrete files (disc_lh, disc_rh) to fsaverage6 using the pial (discrete) surfaces
resample_and_save(disc_lh_path, 'left', 'pial', 'Matlabs/body_disc_lh_fsaverage6_pial.mat')
resample_and_save(disc_rh_path, 'right', 'pial', 'Matlabs/body_disc_rh_fsaverage6_pial.mat')
