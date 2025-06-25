# anthro_emiss 

anthro_emiss creates anthropogenic emissions files from global emission inventories

This is a fortran based preprocessor to create WRF-Chem ready anthropogenic emissions files (wrfchemi__ or wrfchemi_{00z,12z}_) from global inventories on a lat/lon basis. Users are strongly advised to consult the README files before compiling and using the code. See the Download section below.

anthro_emiss with EDGAR-HTAP emissions: For users who like to use the anthro_emiss tool with the global EDGAR-HTAP emission inventory (http://edgar.jrc.ec.europa.eu/national_reported_data/htap.php) we provide inputs needed for mapping to the MOZART-MOSAIC and MOZART-GOCART chemical options - see https://www.acom.ucar.edu/wrf-chem/download.shtml. This package has been provided by Rajesh Kumar (rkumar@ucar.edu).

The recently released EDGARv5.0 emission inventory is now available in MOZART speciation for use with anthro_emiss. See https://zenodo.org/records/6130621#.YhOhDy9w1QI for more information and to download the data set (provided by Caterina Mogno, University of Edinburgh, UK. caterina.mogno@gmail.com). 
