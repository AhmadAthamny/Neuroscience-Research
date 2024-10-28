import scipy.io
import numpy as np

# Load .mat file
mat_file = 'brain_regions/surfaceData_matlab/LH_S1_A1_V1.mat'
data = scipy.io.loadmat(mat_file)

# Assuming the data is in a specific variable name inside the .mat file
# Replace 'your_variable' with the correct one
surface_data = data['vertices']

# Convert to .txt file
output_txt_file = 'brain_regions/surfaceData_txt/LH_S1_A1_V1.txt'
np.savetxt(output_txt_file, surface_data, delimiter=' ')
