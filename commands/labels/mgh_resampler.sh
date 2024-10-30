# Set variables for paths
FSAVERAGE7_MGH="/home/ahmed/Neuroscience-Research/brain_regions/labels/mgh_files/LH_S1_A1_V1.mgh"  # Path to your fsaverage7 .mgh file
FSAVERAGE6_MGH="/home/ahmed/Neuroscience-Research/brain_regions/labels/mgh_files/LH_S1_A1_V1_fsavg6.mgh"  # Desired output file in fsaverage6

# Resample from fsaverage7 to fsaverage6
mri_surf2surf --srcsubject fsaverage7 --trgsubject fsaverage6 \
              --hemi lh --sval "$FSAVERAGE7_MGH" --tval "$FSAVERAGE6_MGH"
