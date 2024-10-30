# Set variables for file paths
TXT_FILE="/home/ahmed/Neuroscience-Research/brain_regions/labels/text_files/LH_S1_A1_V1.txt"        # Update with your .txt file path
MGH_FILE="/home/ahmed/Neuroscience-Research/brain_regions/labels/mgh_files/LH_S1_A1_V1.mgh"                   # Desired output .mgh file

# Command to convert .txt to .mgh
mri_convert --in_type ascii --out_type mgh "$TXT_FILE" "$MGH_FILE"
