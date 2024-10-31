import nibabel as nib
import numpy as np

# Define paths
input_mgh = r"C:\Users\Ahmad Athamny\Documents\University\SummerInternship\Neuroscience-Research\brain_regions\labels\mgh_files\LH_S1_A1_V1.mgh"
output_mgh = r'C:\Users\Ahmad Athamny\Documents\University\SummerInternship\Neuroscience-Research\brain_regions\labels\mgh_files\LH_fsavg7_cleared.mgh'
label_txt = r'C:\Users\Ahmad Athamny\Documents\University\SummerInternship\Neuroscience-Research\brain_regions\labels\label_files\LH_label.txt'


import nibabel as nib
import numpy as np

# Load the original .mgh file with regions
mgh_path = input_mgh  # Use the initial .mgh file
img = nib.load(mgh_path)
data = img.get_fdata()

# Define the region values to keep
region_values = {7: "S1", 2.5: "V1", 3: "A1"}

# Count vertices of each region type before clearing
print("Vertex counts before clearing:")
for value, region_name in region_values.items():
    count = np.sum(data == value)
    print(f"{region_name} (value {value}): {count} vertices")

# Create a mask that retains only defined region values
cleaned_data = np.zeros(data.shape)
for value in region_values:
    cleaned_data[data == value] = value

# Count vertices of each region type after clearing
print("\nVertex counts after clearing:")
for value, region_name in region_values.items():
    count = np.sum(cleaned_data == value)
    print(f"{region_name} (value {value}): {count} vertices")

# Save the cleaned .mgh data
cleaned_mgh_path = output_mgh
cleaned_img = nib.MGHImage(cleaned_data.astype(np.float32), img.affine)
nib.save(cleaned_img, cleaned_mgh_path)
print(f"\nSaved cleaned .mgh file: {cleaned_mgh_path}")


# Find unique values in the original data to understand which regions are present
unique_values, counts = np.unique(data, return_counts=True)
print("Unique values and their counts in the original data:")
for value, count in zip(unique_values, counts):
    print(f"Value {value}: {count} vertices")
