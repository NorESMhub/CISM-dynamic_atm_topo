#!/bin/bash

set -e
set -x

module purge
module load netcdf4-python/1.4.1-intel-2018b-Python-3.6.6

ScratchRun=/cluster/projects/nn9560k/heig/topo/test
export Working_Directory=$ScratchRun/dynamic_atm_topo
export Data_Directory=/cluster/projects/nn9560k/heig/inputdata/CISM

grid=fv_0.9x1.25
glandMaskFile=$Data_Directory/greenland_mask_FV1.nc
topoDatasetDef=$Data_Directory/fv_0.9x1.25_topo_c170415.nc
#grid=fv_1.9x2.5
#glandMaskFile=$Data_Directory/greenland_mask_FV2.nc
#topoDatasetDef=$Data_Directory/fv_1.9x2.5_topo_c061116.nc

export CAM_Restart_File=`ls -t $ScratchRun/*.cam.r.* | head -n 1`

#######

echo "-> Merging datasets..."

# safe orignal CAM file, don't overwrite
camname=`basename $CAM_Restart_File .nc`
if [[ -e $Working_Directory/original_CAM_restarts/$camname.nc || -L $Working_Directory/original_CAM_restarts/$camname.nc ]] ; then
    i=1
    while [[ -e $Working_Directory/original_CAM_restarts/$camname-$i.nc || -L $Working_Directory/original_CAM_restarts/$camname-$i.nc ]] ; do
        let i++
    done
    camname=$camname-$i
fi
cp $CAM_Restart_File $Working_Directory/original_CAM_restarts/$camname.nc

cd $Working_Directory/postproc

topoDataset=$ScratchRun/topoDataset.nc
cp $topoDatasetDef $topoDataset

c2tOutputDir=$Working_Directory/cube_to_target/output
c2t060=$c2tOutputDir/${grid}_nc3000_Nsw042_Nrs008_Co060_Fi001.nc
c2t008=$c2tOutputDir/${grid}_nc3000_NoAniso_Co008_Fi001.nc

which python
python postproc_mask.py $CAM_Restart_File $topoDataset $glandMaskFile $c2t060 $c2t008

if [ $? -ne 0 ]
then
    echo "Python postproc_mask FAILED"
    exit 1
fi 
