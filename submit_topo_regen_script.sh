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

module load NCO/4.9.3-intel-2019b

## Default settings (may be changed from setup.sh)

ScratchRun=/cluster/work/users/heig/noresm/N1850frc2G_f19_tn14_gl4_SMB1_run2/run

ScriptDir=$ScratchRun/dynamic_atm_topo

### ### ### ### ### ### ### ###

CAM_Restart_File=`ls -t $ScratchRun/*.cam.r.* | head -n 1`
CISM_Restart_File=`ls -t $ScratchRun/*.cism.r.* | head -n 1`

## Submit topography regeneration script 
if [[ -f $CISM_Restart_File && -f $CAM_Restart_File ]]; then
    echo "Submitting topography regeneration script"
    raw=$(sbatch $ScriptDir/CAM_topo_regen.sh)
    echo ${raw}
    id=${raw##* }
    echo ${id}
    sleep 3

    # Wait for topo script to finish before running next segment
    # check every minute for an expected 25 min run to finish
    while sleep 60; do
	st=`squeue -j ${id} -o "%t" -h`
	if [[ "$st" == 'R' ]] || [[ "$st" == 'PD' ]] ; then
            echo ${st}: Job still on queue
	else
            break
	fi
    done
    
    echo "Topo job has finished. Continue ..."

fi

## === end of script === ##
