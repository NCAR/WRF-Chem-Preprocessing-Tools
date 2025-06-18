;  code to put aircraft emissions (1x1deg) into WRF-Chem
;  December 2008 (Jeff Lee)

;------------------------------------------------------------------------
FUNCTION read_data, file, month, lonmin, lonmax, latmin, latmax

id=ncdf_open(file)

ncdf_varget, id, 'alt',alt
ncdf_varget, id, 'lon',lon
ncdf_varget, id, 'lat',lat
ncdf_varget, id, 'NO', e_no
ncdf_varget, id, 'CO', e_co
ncdf_varget, id, 'CH4',e_ch4
ncdf_varget, id, 'SO2',e_so2

ncdf_close,id

; select only one month

imonth = month-1
Print, 'Selected month index (0-11): ',imonth

e_no_month  = reform (e_no[*,*,*,imonth])
e_co_month  = reform (e_co[*,*,*,imonth])
e_ch4_month = reform (e_ch4[*,*,*,imonth])
e_so2_month = reform (e_so2[*,*,*,imonth])

;help, e_no_month

; change longitude from 0~360 to -180~180

k=where(lon ge 180)
if k[0] ne -1 then lon[k] = lon[k]-360


; reduce from global to region of interest

;klon = where(lon ge 0)
;klat = where(lat ge -90, nklat)
;klon = where(lon le 40 or lon ge 300)
klon = where(lon ge lonmin and lon le lonmax, nklon)
klat = where(lat ge latmin and lat le latmax, nklat)

lon=lon[klon]
lat=lat[klat]

Print, 'nklon= ', nklon, lon
Print, 'nklat= ', nklat, lat

e_no_month  = e_no_month [klon,klat,*]
e_co_month  = e_co_month [klon,klat,*]
e_ch4_month = e_ch4_month[klon,klat,*]
e_so2_month = e_so2_month[klon,klat,*]

str={alt:alt,lon:lon,lat:lat,e_no:e_no_month,e_co:e_co_month,e_ch4:e_ch4_month,e_so2:e_so2_month}
return, str

end

;------------------------------------------------------------------------
PRO mean_height, emis_height_max,  ph, phb, hgt, eta_dim, wrfheight, wrflevs, dz
; all units in meter

print,emis_height_max  

alt = (ph+phb)/9.81

for i=0,eta_dim-1 do alt[*,*,i]=alt[*,*,i]-hgt

mean_alt = fltarr(eta_dim)

for i=0,eta_dim-1 do begin
 mean_alt[i] = mean(alt[*,*,i]-alt[*,*,0])
;print,i, mean_alt[i], stddev(alt[*,*,i]-alt[*,*,0])
endfor

index = where(mean_alt lt emis_height_max)
wrflevs= n_elements(index)
print, wrflevs, index

wrfheight =fltarr(wrflevs)
wrfheight = mean_alt[index]

print,''
print,'emis_level  model mean_height' 
for i=0,wrflevs-1 do print,i,wrfheight[i]

dz = fltarr(wrflevs)

print,''
print,'emis_level  dz'
for i=0,wrflevs-2 do begin
 dz[i] = mean_alt[i+1]-mean_alt[i]
 print,i, dz[i]
endfor

end 
;-------------------------------------------------------------------------

PRO distance, lat1,lon1,lat2,lon2, d

  r = 6.370e6	
  cutpoint = 1.e-9		
  degToRad = 0.017453293	

  rlat1 = lat1 * degToRad
  rlon1 = -1*lon1 * degToRAD
  rlat2 = lat2 * degToRad
  rlon2 =-1*lon2 * degToRad

  dellat = (rlat2 - rlat1)
  dellon = (rlon2 - rlon1)
  if ( abs(dellat) lE cutpoint ) then d=0

  if ( abs(dellat) gt cutpoint ) then begin
      a = sin (dellat/2.) * sin(dellat/2.) + cos(rlat1)*cos(rlat2) $
        * sin(dellon/2.) * sin(dellon/2.)
      if (a lt 1.00) then begin
          c = 2.*asin(sqrt(a) )
      endif else if a ge 1.0 then begin
          c = 2. * asin(1.00)
      endif
  d = r * c
  endif

end

@mapcf.pro
@ijll_lc.pro
@llij_lc.pro
@create_netcdffile.pro

; Begin of Main Program

;############################################################################
;user modified:

;input wrfinput file 

wrfinput_file  = './wrfinput_d01'

;input emission file

data_file  = './baughcum_1999.aircraft.1x1.nc'

minhour=0     ; which hours of the day emissions should be created
              ; e.g. minhour=0 and maxhour=23 creates emissions for entire day
maxhour=23

;pick the month of emissions
;mm = '06'

domain = 'd01'
yyyy = '2012'
mm = '05'
dd = '21'

;set to zero below maxheight, which must be the same as NEI emission

maxheight = 1000.

;end of user modified
;##############################################################################

output_dir = './'

; get infomation from wrfinput file

id = ncdf_open(wrfinput_file)

ncdf_attget,id,'DX',dx_temp,/GLOBAL
ncdf_attget,id,'WEST-EAST_GRID_DIMENSION',wrf_ii,/GLOBAL
ncdf_attget,id,'SOUTH-NORTH_GRID_DIMENSION',wrf_jj,/GLOBAL
ncdf_attget,id,'BOTTOM-TOP_GRID_DIMENSION',eta_dim,/GLOBAL
;;; GGP
ncdf_attget,id,'CEN_LAT',cen_lat,/GLOBAL
ncdf_attget,id,'CEN_LON',cen_lon,/GLOBAL
ncdf_attget,id,'STAND_LON',stand_lon,/GLOBAL
ncdf_attget,id,'TRUELAT1',truelat1,/GLOBAL
ncdf_attget,id,'TRUELAT2',truelat2,/GLOBAL
ncdf_attget,id,'MAP_PROJ',map_proj,/GLOBAL
ncdf_attget,id,'MOAD_CEN_LAT',moad_cen_lat,/GLOBAL

ncdf_varget,id,'PH',ph
ncdf_varget,id,'PHB',phb
ncdf_varget,id,'HGT',hgt

ncdf_varget,id,'XLONG',xlong
ncdf_varget,id,'XLAT',xlat
ncdf_close,id

; set local values

wrf_ix = wrf_ii - 1
wrf_jx = wrf_jj - 1

dx     = dx_temp/1000.
hemi   =  1
lat1   =  cen_lat
lon1   =  cen_lon
knowni = (wrf_ix+1)/2.
knownj = (wrf_jx+1)/2.

; calculates lat/lon for WRF domain

wrf_lat = fltarr(wrf_ix, wrf_jx)
wrf_lon = fltarr(wrf_ix, wrf_jx)
wrf_lat_ll = fltarr(wrf_ix, wrf_jx)
wrf_lon_ll = fltarr(wrf_ix, wrf_jx)

for i=0,wrf_ix-1 do begin
    for j=0,wrf_jx-1 do begin
        ijll_lc, i+1.5,j+1.5, a, b, truelat1, truelat2, $
          hemi, stand_lon,lat1, lon1, knowni, knownj, dx
        wrf_lat[i,j] = a
        wrf_lon[i,j] = b

        ijll_lc, i+1.,j+1., a, b, truelat1, truelat2, $
          hemi, stand_lon,lat1, lon1, knowni, knownj, dx
        wrf_lat_ll[i,j] = a
        wrf_lon_ll[i,j] = b


    endfor
endfor

; get latmin,latmax,lonmin and lonmax
; rough domain borders (to limit the amount of aircraft data to deal with)
; (pick 5 degree extension on all 4 sides)

degree_extention = 5.0

i=0
j=0

ijll_lc, i,j, a, b, truelat1, truelat2, $
          hemi, stand_lon,lat1, lon1, knowni, knownj, dx

latmin = round(a - degree_extention)
lonmin = round(b - degree_extention)
;print, latmin, lonmin

i=wrf_ix - 1
j=wrf_jx - 1

ijll_lc, i,j, a, b, truelat1, truelat2, $
          hemi, stand_lon,lat1, lon1, knowni, knownj, dx

latmax = round(a + degree_extention)
lonmax = round(b + degree_extention)
;print, latmax, lonmax

; read emission data

data = read_data(data_file, fix(mm), lonmin, lonmax, latmin, latmax )

; find the top altitude (meter) from emission data

; data.alt in km, change it into meter

data_alt = data.alt * 1.e3
print, data_alt

n_alt = n_elements(data_alt)
emis_height_max = data_alt[n_alt-1] 
    
; get wrfheight, wrflevs and dz (unit in meter)

mean_height, emis_height_max, ph, phb, hgt, eta_dim, wrfheight, wrflevs, dz  

;create empty WRF emissions netcdf files

hrs = strcompress(string(indgen(24)),/remove_all)
hrs[0:9] = '0'+hrs[0:9]

;timestring = yyyy+'-'+mm+'-'+dd+'_'+hrs+':00:00'
;file_out = 'wrfaircraftchemi_'+domain+'_'+timestring

;timestring = 'hour_'+hrs 
hrs = strcompress(string(indgen(24)),/remove_all)
hrs[0:9] = '0'+hrs[0:9]
timestring = yyyy+'-'+mm+'-'+dd+'_'+hrs+':00:00'
file_out = 'wrfaircraftchemi_'+domain+'_'+timestring
 
ncfiles = output_dir + file_out

print, ''
print, 'Creating the following files in ', output_dir

for i = minhour, maxhour do begin $

create_netcdffile, ncfiles[i], timestring[i], wrflevs, wrf_ix, wrf_jx, dx*1e3, dx*1e3, lat1, lon1, truelat1, truelat2, moad_cen_lat, eta_dim, wrfheight, map_proj

print,i+1,'   ', file_out[i]

endfor

; read aircraft emissions data
; spatial assignment aircraft -> WRFgrid (simple match by looking for the
; aircraft grid box nearest to a WRF pixel)

openw,1,'data_WRFassign_dat'

printf,1,wrf_ix, wrf_jx, wrflevs

d=-99
dist = fltarr(wrf_ix, wrf_jx)-999.  ; distance in meters between aircraft cell center and WRF cell center

; find the nearest horizontal data point

index_lat = intarr(wrf_ix, wrf_jx)
index_lon = intarr(wrf_ix, wrf_jx)

for ix=0,wrf_ix-1 do begin
    for jx=0,wrf_jx-1 do begin
        klat = where (abs(wrf_lat[ix,jx]-data.lat) eq min(abs(wrf_lat[ix,jx]-data.lat)))
        klon = where (abs(wrf_lon[ix,jx]-data.lon) eq min(abs(wrf_lon[ix,jx]-data.lon)))
        distance,data.lat[klat[0]],data.lon[klon[0]],wrf_lat[ix,jx], wrf_lon[ix,jx], d  
        dist[ix,jx] = d
        index_lat[ix,jx] = klat[0]
        index_lon[ix,jx] = klon[0]
        printf, 1,ix, jx, data.lat[klat[0]],data.lon[klon[0]],wrf_lat[ix,jx], wrf_lon[ix,jx], d*1e-3, format='(2I10, 5F10.3)'
    endfor
endfor

; find the nearest vertical data point

index_alt = intarr(wrflevs)

; data_alt is data.alt*1.e3 
d_to_data_alt = data_alt

for k=0,wrflevs-1 do begin

    for i=0,n_alt-1 do begin
        d_to_data_alt[i] = abs( wrfheight[k] - data_alt[i] )
    endfor

    index_alt[k] = where ( d_to_data_alt eq min(d_to_data_alt) )
       
    printf, 1, k, index_alt[k], format='(2I10)'
    
endfor

close,1

;convert emission unit from molecules/cm3/sec to mole/km2/hour
;note: dz in meter

arg_number = 6.022e23
;;factor = 1.e5 * 1.e5 * 1.e2 *3600./arg_number
factor = 1e5 * 1e5 *3600./arg_number
for hrloop = minhour, maxhour do begin

print, wrf_ix, wrf_jx, wrflevs
dummy=''
    no_emis  = fltarr(wrf_ix, wrf_jx, wrflevs)
    co_emis  = fltarr(wrf_ix, wrf_jx, wrflevs)
    ch4_emis = fltarr(wrf_ix, wrf_jx, wrflevs)
    so2_emis = fltarr(wrf_ix, wrf_jx, wrflevs)

    for i = 0, wrf_ix-1  do begin
    for j = 0, wrf_jx-1  do begin
    for k = 0, wrflevs-1 do begin
        no_emis [i,j,k] = data.e_no [index_lon[i,j], index_lat[i,j], index_alt[k]] *1e5 * factor ;* dz[k] 
        co_emis [i,j,k] = data.e_co [index_lon[i,j], index_lat[i,j], index_alt[k]] *1e5 * factor ;* dz[k] 
        ch4_emis[i,j,k] = data.e_ch4[index_lon[i,j], index_lat[i,j], index_alt[k]] *1e5 * factor ;* dz[k]          
        so2_emis[i,j,k] = data.e_so2[index_lon[i,j], index_lat[i,j], index_alt[k]] *1e5 * factor ;* dz[k] 

    endfor
;plot, data.e_no [index_lon[i,j], index_lat[i,j],*] *factor * 1e-5, data.alt
;oplot,no_emis [i,j,*], wrfheight*1e-3, color=220
;read,dummy
    endfor
endfor

; set lowest km to zero (ac emissions included in anthropogenic
; emissions)

ilev=where(wrfheight le maxheight)
if ilev[0] ne -1 then begin
    no_emis[*,*,ilev] = 0.
    co_emis[*,*,ilev] = 0.
    ch4_emis[*,*,ilev] = 0.
    so2_emis[*,*,ilev] = 0.
endif

; write to netcdf  files

    ncid = ncdf_open(ncfiles[hrloop],/write)
    print,'Writing to ',ncfiles[hrloop]

    ncdf_varput,ncid,'EAC_NO',  no_emis 
    ncdf_varput,ncid,'EAC_CO',  co_emis
    ncdf_varput,ncid,'EAC_CH4', ch4_emis
    ncdf_varput,ncid,'EAC_SO2', so2_emis 

    ncdf_close,ncid
    
endfor               ; end of hour loop

;spawn, 'ncrcat wrfaircraftchemi_hour_0* wrfaircraftchemi_hour_10 wrfaircraftchemi_hour_11  wrfaircraftchemi_00z_d01'
;spawn, 'ncrcat wrfaircraftchemi_hour_1[23456789] wrfaircraftchemi_hour_2* wrfaircraftchemi_12z_d01'
 
;spawn, 'rm wrfaircraftchemi_hour_*' 

end
