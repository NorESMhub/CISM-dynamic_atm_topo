#!/bin/bash
#
# This script has two main purposes:
# (1) Submit topography regeneration as a separate 
#     process running in parallel with NorESM submission
#
# (2) Merge updated topography with CAM restart 
#     file if possible
#
# Author:
# M. Lofverstrom
# NCAR, April 2017
# Modified: 
# Heiko Goelzer, NORCE 2021
###########################
# 
# Adapted to NorESM on fram
#
###########################

module load NCO/4.7.9-intel-2018b

## Default settings (may be changed from setup.sh)

ScratchRun=/cluster/work/users/heig/noresm/N1850frc2G_f09_tn14_gl4_topo_20210223/run
ScriptDir=$ScratchRun/dynamic_atm_topo

### ### ### ### ### ### ### ###

CAM_Restart_File=`ls -t $ScratchRun/*.cam.r.* | head -n 1`
CISM_Restart_File=`ls -t $ScratchRun/*.cism.r.* | head -n 1`

## Submit topography regeneration script 
if [[ -f $CISM_Restart_File && -f $CAM_Restart_File ]]; then
    echo "Submitting topography regeneration script"
    sbatch $ScriptDir/CAM_topo_regen.sh
fi

## === end of script === ##
