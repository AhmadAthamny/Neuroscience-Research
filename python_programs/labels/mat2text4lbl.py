import scipy.io as sio
import numpy as np

# Load .mat file
mat_data = sio.loadmat('brain_regions\\surfaceData_matlab\\RH_S1_A1_V1.mat')

# Extract region values from the .mat file (adjust keys as necessary)
region_data = mat_data["vertices"]  # Replace 'region_data' with actual key
output_data = np.zeros_like(region_data)

# Define unique values for each region
output_data[region_data == 7] = 1  # S1 label
output_data[region_data == 3] = 2  # A1 label
output_data[region_data == 2.5] = 3  # V1 label

# Save to text file
np.savetxt('brain_regions\\lbl_txt\\RH_S1_A1_V1.txt', output_data, fmt='%d')
