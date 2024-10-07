from nilearn import datasets, surface, plotting
import scipy.io as sio
from matplotlib.colors import LinearSegmentedColormap, ListedColormap

def load_mat(fname):
    data = sio.loadmat(fname)
    key = list(data.keys())[3]
    return data[key].squeeze()

body_colors = ['darkblue', 'blue', 'cyan', 'green', 'lawngreen', 'yellow', 'orange', 'red']
cont_body_cmap = LinearSegmentedColormap.from_list("cont_body_cmap", body_colors)
disc_cmap = ListedColormap(body_colors, name='disc_cmap')

fsaverage = datasets.fetch_surf_fsaverage('fsaverage')

bg_map_lh = surface.load_surf_data(fsaverage['curv_left'])
bg_map_lh[bg_map_lh >= 0] = 0.75
bg_map_lh[bg_map_lh < 0] = 0.5

bg_map_rh = surface.load_surf_data(fsaverage['curv_right'])
bg_map_rh[bg_map_rh >= 0] = 0.75
bg_map_rh[bg_map_rh < 0] = 0.5

data = load_mat('body_disc_lh.mat')
view = plotting.view_surf(fsaverage['infl_left'], data, bg_map=bg_map_lh, cmap=disc_cmap, symmetric_cmap=False, threshold=0.00001)
                                        
view.open_in_browser()