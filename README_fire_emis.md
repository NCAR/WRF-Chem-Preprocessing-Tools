# fire_emis

fire_emis creates fire emissions files for use with the online plumerise in WRF-Chem and also for CAM-Chem

Fortran based preprocessor for creating fire emission inputs for WRF-Chem when running with plumerise and also for creating fire emission inputs for the CAM-Chem global models. The fire emissions inventory is based on the Fire Inventory from NCAR (FINN).

You have to setup three directories {data_files, src, and test}.  The data_files directory is where users should put the FINN files and the wrfinput_dfile(s). The test directory contains  test namelist input files, both for creating WRF inputs and  for creating global inputs. Users are highly advised to read the README files before using the fire emission utility.

FINNv2.5 input emissions can be downloaded from the RDA: https://rda.ucar.edu/datasets/ds312.9/index.html
