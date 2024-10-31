import numpy as np
import nibabel as nib

# Load the data from the .txt file
txt_file_path = r'C:\Users\Ahmad Athamny\Documents\University\SummerInternship\Neuroscience-Research\brain_regions\labels\text_files\RH_S1_A1_V1.txt'
mgh_file_path = r'C:\Users\Ahmad Athamny\Documents\University\SummerInternship\Neuroscience-Research\brain_regions\labels\mgh_files\RH_S1_A1_V1.mgh'

# Assuming the .txt file is organized by vertex with each row as a single value
data = np.loadtxt(txt_file_path, dtype=np.float32)  # Ensure data is in float32

# Create an identity affine for simplicity
affine = np.eye(4)

# Save data to .mgh using nibabel
mgh_image = nib.MGHImage(data.reshape(-1, 1, 1), affine)
nib.save(mgh_image, mgh_file_path)
