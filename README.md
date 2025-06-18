Creates lateral boundary and initial conditions from global chemistry model output.

NCAR/ACOM has developed a program to create time-varying chemical lateral boundary conditions for WRF-Chem from CAM-chem output. For questions about running mozbc please use our WRF-Chem Discussion Forum contacting wrf-chem-mozbc.
For  modifications required to run mozbc with the new WRF hybrid coordinate, please see the discussions in the User Forum (Subject line: [WRF-Chem mozbc] mozbc in WRF 3.9 or Greater)

To obtain mozbc, see the Download section below.
IMPORTANT: Please note that mozbc is not yet working with the hybrid sigma-pressure vertical coordinate introduced with WRF V3.9.

To obtain CAM-chem output files use the CAM-chem Download page. Note that mozbc also has the option to set species to a single fixed value. This is especially relevant for long-lived and well distributed species (e.g. CH4, H2 or N2O) if they are not on the global model output.

The reference for the CAM-chem output is:

Buchholz, R. R., Emmons, L. K., Tilmes, S., & The CESM2 Development Team. (2019). CESM2.1/CAM-chem Instantaneous Output for Boundary Conditions. UCAR/NCAR - Atmospheric Chemistry Observations and Modeling Laboratory. Subset used† XXX, Accessed* dd mmm yyyy, https://doi.org/10.5065/NMP7-EP60.

†Please fill in the "subset used" with region and/or date of the subset you used (e.g. Lat: -10 to 10, Lon: 100 to 150, September 2015 - February 2016).
*Please fill in the "Accessed" date with the day, month, and year that you last accessed the data (e.g. - 5 Aug 2011).

Near-real-time global chemical forecast output from the WACCM model is also available for use as regional model boundary conditions.

Mapping of WACCM or CAM-chem gas-phase and aerosol species to WRF-Chem chemistry is provided in this document: CESM-WRFchem_aerosols_20190822.pdf.
