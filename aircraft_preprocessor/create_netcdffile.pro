PRO create_netcdffile, emisfile, timestring, zdim, WE, SN, dx, dy, cenlat, cenlon, truelat1, truelat2, moad_cen_lat, eta_dim, z, mapproj

ncid = ncdf_create(emisfile, /clobber)

; create dimensions

timeid = ncdf_dimdef(ncid, 'Time',/UNLIMITED)  
weid   = ncdf_dimdef(ncid, 'west_east',WE) 
snid   = ncdf_dimdef(ncid, 'south_north',SN) 
btid   = ncdf_dimdef(ncid, 'bottom_top',eta_dim)
stagid = ncdf_dimdef(ncid,'ac_emissions_zdim_stag',zdim)
datestrlenid = ncdf_dimdef(ncid, 'DateStrLen',19)

; write global attributes

ncdf_attput,ncid,/GLOBAL,/long,'WEST-EAST_GRID_DIMENSION',WE+1
ncdf_attput,ncid,/GLOBAL,/long,'SOUTH-NORTH_GRID_DIMENSION',SN+1
ncdf_attput,ncid,/GLOBAL,/long,'BOTTOM-TOP_GRID_DIMENSION',eta_dim
ncdf_attput,ncid,/GLOBAL,/char, 'TITLE','Created by Jeff Lee'
ncdf_attput,ncid,/GLOBAL,/float,'DX',dx
ncdf_attput,ncid,/GLOBAL,/float,'DY',dy
ncdf_attput,ncid,/GLOBAL,/float,'HEIGHT',z
ncdf_attput,ncid,/GLOBAL,/float,'CEN_LAT',cenlat
ncdf_attput,ncid,/GLOBAL,/float,'CEN_LON',cenlon
ncdf_attput,ncid,/GLOBAL,/float,'TRUELAT1',truelat1
ncdf_attput,ncid,/GLOBAL,/float,'TRUELAT2',truelat2
ncdf_attput,ncid,/GLOBAL,/float,'MOAD_CEN_LAT',moad_cen_lat
ncdf_attput,ncid,/GLOBAL,/long,'MAP_PROJ',mapproj

; define varaiable fields

tvarid = ncdf_vardef(ncid,'Times',[datestrlenid, timeid ],/char)

varid = ncdf_vardef(ncid, 'EAC_NO', [weid,snid,stagid, timeid], /FLOAT)
ncdf_attput,ncid,'EAC_NO', 'FieldType',  /long, 104
ncdf_attput,ncid,'EAC_NO', 'MemoryOrder',/char,'XYZ'
ncdf_attput,ncid,'EAC_NO', 'description',/char,'EMISSIONS'
ncdf_attput,ncid,'EAC_NO', 'units',      /char,'mole km-2 hr-1'
ncdf_attput,ncid,'EAC_NO', 'stagger',    /char,'Z'

varid = ncdf_vardef(ncid, 'EAC_CO', [weid,snid,stagid, timeid], /FLOAT)
ncdf_attput,ncid,'EAC_CO', 'FieldType',  /long, 104
ncdf_attput,ncid,'EAC_CO', 'MemoryOrder',/char,'XYZ'
ncdf_attput,ncid,'EAC_CO', 'description',/char,'EMISSIONS'
ncdf_attput,ncid,'EAC_CO', 'units',      /char,'mole km-2 hr-1'
ncdf_attput,ncid,'EAC_CO', 'stagger',    /char,'Z'

varid = ncdf_vardef(ncid, 'EAC_CH4', [weid,snid,stagid, timeid], /FLOAT)
ncdf_attput,ncid,'EAC_CH4', 'FieldType',  /long, 104
ncdf_attput,ncid,'EAC_CH4', 'MemoryOrder',/char,'XYZ'
ncdf_attput,ncid,'EAC_CH4', 'description',/char,'EMISSIONS'
ncdf_attput,ncid,'EAC_CH4', 'units',      /char,'mole km-2 hr-1'
ncdf_attput,ncid,'EAC_CH4', 'stagger',    /char,'Z'

varid = ncdf_vardef(ncid, 'EAC_SO2', [weid,snid,stagid, timeid], /FLOAT)
ncdf_attput,ncid,'EAC_SO2', 'FieldType',  /long, 104
ncdf_attput,ncid,'EAC_SO2', 'MemoryOrder',/char,'XYZ'
ncdf_attput,ncid,'EAC_SO2', 'description',/char,'EMISSIONS'
ncdf_attput,ncid,'EAC_SO2', 'units',      /char,'mole km-2 hr-1'
ncdf_attput,ncid,'EAC_SO2', 'stagger',    /char,'Z'

ncdf_control,ncid, /endef

; write fields

ncdf_varput,ncid,'Times',timestring

ncdf_close,ncid

end



