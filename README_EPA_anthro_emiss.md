**EPA_anthro_emiss**

The tool allows users to create WRF-Chem compatible hourly anthropogenic emission input files from Sparse Matrix Operator Kernel (SMOKE) Modeling System netcdf output. Please consult the EPA_ANTHRO_EMIS User Guide and the README included in the download before using the tool.  A sample input data set containing the U.S. EPA 2014v2 emissions is available for download at https://www.acom.ucar.edu/Models/EPA/. 
For use with the U.S. EPA 2014v2 emissions, users also will need to place the sectorlist_2014fd_nata file into the data directory. 

U.S.EPA NEI 2017 input data are now available for download (https://www.acom.ucar.edu/wrf-chem/EPA_2017/). These data have been made available to the community by Alison Eyth and Barron Henderson at U.S. EPA. For more information on NEI 2017 see the U.S. EPA report “Derived Estimates of Air Quality for 2017” (https://ofmpub.epa.gov/rsig/rsigserver?data/FAQSD/docs/2017_DS_Annual_Report.pdf). EPA_ANTHRO_EMIS can be used with the new data set but it will require updates to the namelist input file. See the README in the download for more information.  An example input file for the MOZCART-T1 mechanism is included in the package.
