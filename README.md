# dynamic_atm_topo
Dynamic topography update for NorESM2
These scripts are based on CESM2 work provided by Kate Thayer-Calder 
In addition, there is now an option to run in anomaly mode (not tested)

1. Set up your case. You'll need to get to the point where a run directory is built, so at least past case.setup, but you don't need built NorESM source.

2. Copy the directory dynamic_atm_topo into your case run directory
[e.g. git clone -b noresm2-betzy  git@github.com:hgoelzer/dynamic_atm_topo.git]

3. Build the code in dynamic_atm_topo/ . Just go into "bin_to_cube" and type "make clean" and then "make" with a fortran compiler module loaded. Should be fine. Do the same for "cube_to_target"

4. Edit "CAM_topo_regen.sh" to work with your project, by adjusting ScratchRun.

5. Edit the submit_topo_regen_script.sh to work with your project, by adjusting ScratchRun.

6. The magic incantation for NorESM is, in your case directory, ./xmlchange POSTRUN_SCRIPT=/cluster/work/users/<USER>/noresm/<CASE>/run/dynamic_atm_topo/CAM_topo_regen.sh 
 
If you do just run the topography updater "manually" all you need to do is call the CAM_topo_regen.sh from an interactive single process session. It doesn't require MPI. It does require the amount of memory on a compute node, rather than a login node. 

# Manual run
Adjust 'ScratchRun=' in submit_topo_regen_script.sh 
Adjust 'ScratchRun=' and check 'Data_Directory=' in CAM_topo_regen.sh 
./submit_topo_regen_script.sh



# Currently unused 
But could be used to setup for different architectures: 
setup.sh, template.topo_regen, defaultScripts

Manual run in anomaly
Adjust 'ScratchRun=' in submit_topo_anom_regen_script.sh 
Adjust 'ScratchRun=', 'ISM_Topo_File_ref=' and 'ISM_Topo_File_mod0=' and check 'Data_Directory=' in CAM_topo_anom_regen.sh 
./submit_topo_anom_regen_script.sh

