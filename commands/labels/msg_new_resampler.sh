# Set paths for the input and output files
FSAVERAGE7_MGH="/home/ahmed/Neuroscience-Research/brain_regions/labels/mgh_files/RH_S1_A1_V1.mgh"  # fsaverage7 .mgh file
FSAVERAGE6_MGH="/home/ahmed/Neuroscience-Research/brain_regions/labels/mgh_files/RH_S1_A1_V1_fsavg6_nnf.mgh"  # Output file in fsaverage6

# Use mri_surf2surf with nnf (nearest neighbor forward) mapping method
mri_surf2surf --srcsubject fsaverage --trgsubject fsaverage6 \
              --hemi rh --sval "$FSAVERAGE7_MGH" --tval "$FSAVERAGE6_MGH" \
              --mapmethod nnf
