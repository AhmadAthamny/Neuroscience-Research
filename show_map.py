# Import necessary libraries and modules from nilearn, scipy, and matplotlib
from nilearn import datasets, surface, plotting
import scipy.io as sio
from matplotlib.colors import LinearSegmentedColormap, ListedColormap

# Function to load data from a .mat file (MATLAB format)
def load_mat(fname):
    data = sio.loadmat(fname)  # Load the .mat file
    key = list(data.keys())[3]  # Extract the key (the 4th one) which contains the relevant data
    return data[key].squeeze()  # Return the data array and squeeze it to remove single-dimensional entries

# Define a list of colors for visualizing the data
body_colors = ['darkred', 'darkslateblue', 'lightblue', 'lime', 'green', 'yellow', 'darkorange', 'red']

# Create a continuous color map from the list of colors (for gradient transitions)
cont_body_cmap = LinearSegmentedColormap.from_list("cont_body_cmap", body_colors)

# Create a discrete color map (for distinct color transitions)
disc_cmap = ListedColormap(body_colors, name='disc_cmap')

# Fetch the fsaverage dataset from nilearn (standard surface template of the brain)
fsaverage = datasets.fetch_surf_fsaverage('fsaverage')

# Load the left hemisphere curvature map to be used as a background
bg_map_lh = surface.load_surf_data(fsaverage['curv_left'])

# Set background values for left hemisphere: 0.75 for positive values, 0.5 for negative values
bg_map_lh[bg_map_lh >= 0] = 0.75
bg_map_lh[bg_map_lh < 0] = 0.5

# Load the right hemisphere curvature map for background use
bg_map_rh = surface.load_surf_data(fsaverage['curv_right'])

# Apply the same background value rules for the right hemisphere
bg_map_rh[bg_map_rh >= 0] = 0.75
bg_map_rh[bg_map_rh < 0] = 0.5

# Load the data from the specified .mat file (assumed to contain data for the left hemisphere)
data = load_mat('body_disc_lh.mat')

# Create a view of the brain surface for the left hemisphere, overlaying the data
# Use the loaded background map and the discrete color map created earlier
view = plotting.view_surf(fsaverage['infl_left'], data, bg_map=bg_map_lh, cmap=disc_cmap, symmetric_cmap=False, threshold=0.00001)

# Open the generated brain surface view in a web browser
view.open_in_browser()
