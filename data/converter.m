data = load('surface_data.mat'); % Assuming surface data structure
g = gifti(struct('vertices', data.vertices, 'faces', data.faces));
save(g, 'inflated_rh.surf.gii'); % Save as surface GIFTI file
