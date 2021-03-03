&topoparams
  grid_descriptor_fname           = '/cluster/projects/nn9560k/heig/inputdata/CISM/fv_0.9x1.25.nc'
  output_grid                     = 'fv_0.9x1.25'
  intermediate_cubed_sphere_fname = '/cluster/work/users/heig/noresm/N1850frc2G_f09_tn14_gl4_topo_20210223/run/dynamic_atm_topo/bin_to_cube/ncube3000.nc'
  output_fname                    = 'junk'
  externally_smoothed_topo_file   = 'junk'
  lsmooth_terr = .false.
  lexternal_smooth_terr = .false.
  lzero_out_ocean_point_phis = .false.
  lzero_negative_peaks = .true.
  lsmooth_on_cubed_sphere = .true.
  ncube_sph_smooth_coarse = 8
  ncube_sph_smooth_fine = 1
  ncube_sph_smooth_iter = 1
  lfind_ridges = .false.
  lridgetiles = .false.
  nwindow_halfwidth = 42
  nridge_subsample = 8
  lread_smooth_topofile = .true.
/
