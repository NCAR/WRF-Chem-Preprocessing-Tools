PRO ijll_lc, i, j, lat, lon, truelat1, truelat2, hemi, stdlon,lat1, lon1, knowni, knownj, dx

; Subroutine to convert from the (i,j) cartesian coordinate to the 
; geographical latitude and longitude for a Lambert Conformal projection.
; taken from WRF WPS geogrid
 

rad_per_deg =  !pi/180.
deg_per_rad =  180/!pi
rebydx = 6370./dx


chi1 = (90. -hemi*truelat1)*rad_per_deg
chi2 = (90. -hemi*truelat2)*rad_per_deg
 
; See if we are in the southern hemispere and flip the indices
; if we are. 
inew = hemi * i
jnew = hemi * j
  
; Compute radius**2 to i/j location 

reflon = stdlon + 90.
ala1 = lat1 * rad_per_deg
alo1 = (lon1 - reflon) * rad_per_deg
scale_top = 1. + hemi * SIN(truelat1 * rad_per_deg)

deltalon1 = lon1 - stdlon
IF (deltalon1 gt +180.) then deltalon1 = deltalon1 - 360.
IF (deltalon1 lt -180.) then deltalon1 = deltalon1 + 360.

IF (ABS(truelat1-truelat2) gt 0.1) THEN begin
    cone = ALOG10(COS(truelat1*rad_per_deg)) - $
      ALOG10(COS(truelat2*rad_per_deg))
    cone = cone /(ALOG10(TAN((45.0 - ABS(truelat1)/2.0) * rad_per_deg)) - $
                  ALOG10(TAN((45.0 - ABS(truelat2)/2.0) * rad_per_deg)))        
endif else if (ABS(truelat1-truelat2) le 0.1) then begin
    cone = SIN(ABS(truelat1)*rad_per_deg )  
ENDIF

tl1r = truelat1 * rad_per_deg
ctl1r = COS(tl1r)
rsw = rebydx * ctl1r/cone * (TAN((90.*hemi-lat1)*rad_per_deg/2.) / (TAN((90.*hemi-truelat1)*rad_per_deg/2.)))^cone
arg = cone*(deltalon1*rad_per_deg)
polei = hemi*knowni - hemi * rsw * SIN(arg)
polej = hemi*knownj + rsw * COS(arg)  

xx = inew - polei
yy = polej - jnew
r2 = (xx*xx + yy*yy)
r = SQRT(r2)/rebydx



;Convert to lat/lon
IF (r2 eq  0.) THEN begin
    lat = hemi * 90.
    lon = stdlon
endif else if r2 ne 0 then begin
         
    lon = stdlon + deg_per_rad * ATAN(hemi*xx,yy)/cone

;    lon = AMOD(lon+360., 360.)
 
lon = lon+360 MOD 360.  
    
    IF (chi1 eq chi2) THEN begin
        chi = 2.0*ATAN( ( r/TAN(chi1) )^(1./cone) * TAN(chi1*0.5) )
    endif ELSE if chi1 ne chi2 then begin
        chi = 2.0*ATAN( (r*cone/SIN(chi1))^(1./cone) * TAN(chi1*0.5)) 
    ENDIF
    lat = (90.0-chi*deg_per_rad)*hemi
ENDIF
  
IF (lon gt +180.) then  lon = lon - 360.
IF (lon lt -180.) then lon = lon + 360.
 
end
