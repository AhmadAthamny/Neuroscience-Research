import nibabel as nib
import numpy as np

# Define paths
input_mgh = r"C:\Users\Ahmad Athamny\Documents\University\SummerInternship\Neuroscience-Research\brain_regions\labels\mgh_files\RH_S1_A1_V1_fsavg6.mgh"
output_mgh = r'C:\Users\Ahmad Athamny\Documents\University\SummerInternship\Neuroscience-Research\brain_regions\labels\mgh_files\RH_S1_A1_V1_clrd.mgh'
label_txt = r'C:\Users\Ahmad Athamny\Documents\University\SummerInternship\Neuroscience-Research\brain_regions\labels\label_files\RH_label.txt'


# Define region values and optional colors
regions = {
    "S1": {"value": 7, "color": [1, 0, 0]},     # Red
    "V1": {"value": 2.5, "color": [0, 0, 1]},   # Blue
    "A1": {"value": 3, "color": [0, 1, 0]}      # Green
}

# Load the .mgh file
mgh_data = nib.load(input_mgh)
data = mgh_data.get_fdata().squeeze()

# Identify valid values and set others to zero
valid_values = {region["value"] for region in regions.values()}
cleaned_data = np.where(np.isin(data, list(valid_values)), data, 0).astype(np.float32)

# Save the cleaned data as a new .mgh file
affine = mgh_data.affine
cleaned_mgh = nib.MGHImage(cleaned_data.reshape(data.shape), affine)
cleaned_mgh.to_filename(output_mgh)

# Create label.txt file
with open(label_txt, "w") as f:
    for region_name, region_info in regions.items():
        region_value = region_info["value"]
        color = region_info["color"]
        f.write(f"{region_value} {region_name} {color[0]} {color[1]} {color[2]}\n")

print("Cleaned .mgh and label.txt created successfully!")
