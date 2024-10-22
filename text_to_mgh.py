import numpy as np
import nibabel as nib

# Load surface data from text file
surface_data = np.loadtxt('brain_regions/surfaceData_txt/LH_S1_A1_V1.txt')

# Define shape (based on known number of vertices for fsaverage7)
shape = (163842, 1, 1)

# Create affine matrix (identity matrix for surface data)
affine = np.eye(4)

# Convert surface data to float32 (required for MGH format)
surface_data = surface_data.astype(np.float32)

# Create MGH image and save it
img = nib.MGHImage(surface_data.reshape(shape), affine)
nib.save(img, 'brain_regions/surfaceData_mgh/LH_S1_A1_V1.mgh')
