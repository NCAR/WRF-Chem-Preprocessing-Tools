# Overview
This repository includes preprocessing tools for WRF-Chem developed by the National Science Foundation (NSF) National Center for Atmospheric Research (NCAR) Atmospheric Chemistry Observations and Modeling (ACOM) Laboratory: </br>

**mozbc:** Creates lateral boundary and initial conditions from global chemistry model output </br>
**anthro_emiss:** Creates anthropogenic emission files from global emission inventories </br>
**epa_anthro_emiss:** Creates anthropogenic emission files from Sparse Matrix Operator Kernel (SMOKE) Modeling System netcdf output  </br>
**bio_emiss:** Creates biogenic emission input files for use with MEGAN online emissions  </br>
**fire_emiss:** Creates fire emissions from Fire INventory from NCAR (FINN) input   </br>

Please see the individual README files for more information.   </br>

## **To download the entire repository:** </br>
Users can click the green 'code' button to see the address for a git clone command, or the option to download a zip file. </br>
E.g. using git a user would issue: git clone git@github.com:NCAR/WRF-Chem-Preprocessing-Tools.git </br>


## **To download individual packages using git:** </br>
(see also: https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository) </br>
  mkdir mozbc </br>
  cd mozbc </br>
  git init </br>
  git remote add -f origin git@github.com:NCAR/WRF-Chem-Preprocessing-Tools.git </br>
  git config core.sparseCheckout true </br>
  echo "mozbc" >> .git/info/sparse-checkout  </br>
  git pull origin main </br>


The directory **"Other-Documents"** contains User Guides for running WRF-Chem with the suite of MOZART chemical mechanisms, an overview presentation on the preprocessing tools, information on online trajectories and the Integrated Reaction Rate Analysis diagnostics as well as instructions and input data for running WRF-Chem with phot_opt=4 (TUV).

*We ask users of the WRF-Chem preprocessor tools to include in any publications the following acknowledgement:
"We acknowledge use of the WRF-Chem preprocessor tool {mozbc, fire_emiss, etc.} provided by the Atmospheric Chemistry Observations and Modeling Lab (ACOM) of NCAR."*
