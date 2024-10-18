import os
import subprocess

# Paths to mapped directories
MAPPED_DIR = './_mapped'  # Set this to your _mapped directory path
SPECIES_SURF_DIR = './species_surfaces'  # Set this to your species_surfaces directory
VIEWER_COMMAND = 'wb_view'

def list_species(mapped_dir, data_type, hemisphere):
    """
    List all species for a given data type (discrete/inflated) and hemisphere (left/right).
    """
    species_files = []

    data_type = "disc" if data_type == "discrete" else "infl"
    hemisphere = "lh" if hemisphere == "left" else "rh"

    folder = f'{mapped_dir}/{data_type}_{hemisphere}'
    
    if os.path.exists(folder):
        species_files = os.listdir(folder)
    else:
        print(f"Error: {folder} does not exist.")
    
    return species_files

def run_viewer(species_file, hemisphere, data_type):
    """
    Run wb_view command with species surface and functional data.
    """
    data_type = "disc" if data_type == "discrete" else "infl"
    hemi_side = "L" if hemisphere == "left" else "R"

    # Build the path for the species surface file
    species_surf = SPECIES_SURF_DIR + f"/{species_file}_hemi-{hemi_side}.surf.gii"
    
    # Check if the surface file exists
    if not os.path.exists(species_surf):
        print(f"Error: Surface file not found: {species_surf}")
        return
    
    hemisphere_abbr = "lh" if hemisphere == "left" else "rh"
    func_file = MAPPED_DIR + f"/{data_type}_{hemisphere_abbr}/{species_file}_{hemisphere_abbr}.func.gii"
    print("the func file:", func_file)
    
    # Check if the functional data file exists
    if not os.path.exists(func_file):
        print(f"Error: Functional file not found: {func_file}")
        return

    # Run the wb_view command with both the surface and functional overlay
    try:
        subprocess.run([VIEWER_COMMAND, species_surf, func_file])
    except Exception as e:
        print(f"Error running viewer: {e}")


def main():
    # Step 1: Select between discrete or inflated
    data_type = input("Choose the type (discrete/inflated): ").strip().lower()
    if data_type not in ['discrete', 'inflated']:
        print("Invalid selection. Choose either 'discrete' or 'inflated'.")
        return

    # Step 2: Select between left or right hemisphere
    hemisphere = input("Choose hemisphere (left/right): ").strip().lower()
    if hemisphere not in ['left', 'right']:
        print("Invalid selection. Choose either 'left' or 'right'.")
        return
    
    # Step 3: List available species and choose one
    species_files = list_species(MAPPED_DIR, data_type, hemisphere)
    
    if species_files:
        print("Available species files:")
        for idx, species_file in enumerate(species_files, start=1):
            species_file = species_file.split("_")[1]
            print(f"{idx}. {species_file}")
        
        try:
            selection = int(input("Choose the number of the species to view: ")) - 1
            if 0 <= selection < len(species_files):
                divided_name = species_files[selection+1].split("_")
                selected_species = divided_name[0] + "_" + divided_name[1]
                print(f"Loading {selected_species} ...")
                run_viewer(selected_species, hemisphere, data_type)
            else:
                print("Invalid species selection.")
        except ValueError:
            print("Invalid input. Please enter a number.")
    else:
        print(f"No species files found for {data_type} {hemisphere}.")

if __name__ == "__main__":
    main()
