# Import necessary libraries and modules from nilearn, scipy, and matplotlib
import numpy as np
import scipy.io as sio
from nilearn import surface

# Function to load data from a .mat file (MATLAB format)
def load_mat(fname):
    data = sio.loadmat(fname)  # Load the .mat file
    key = list(data.keys())[3]  # Extract the key (the 4th one) which contains the relevant data
    return data[key].squeeze()  # Return the data array and squeeze it to remove single-dimensional entries

def get_area_vertices(hemi, areaNames):
    vert = []
    parc = load_mat(f'brain_regions/HCP_180_POIs_{hemi}.mat')
    hcpAreaNames = [i[0].item() for i in parc[:, 4]]
    for n in areaNames:
        vert.extend(parc[hcpAreaNames .index(f'{hemi[0].upper()}_{n}_ROI'), 1].squeeze())
    return np.array(vert)

def build_surface_file(hemi, regions_dict):
    vertices_dict = dict()
    for region in regions_dict:
        data = regions_dict[region]
        reg_vertices = get_area_vertices(hemi, data[0])
        vertices_dict[region] = reg_vertices

    file_data = np.zeros(163842)
    for reg in regions_dict:
        color = regions_dict[reg][1]
        for vec in vertices_dict[reg]:
            file_data[vec] = color
    
    sio.savemat("tmp_output.mat", {'vertices': file_data})
        


if __name__ == '__main__':
    regions_dict = dict()
    regions_dict["S1"] = (['1', '2', '3a', '3b'], 7)
    regions_dict["A1"] = (['A1'], 3)
    regions_dict["V1"] = (['V1'], 2.5)

    build_surface_file('LH', regions_dict)
    print("done")

