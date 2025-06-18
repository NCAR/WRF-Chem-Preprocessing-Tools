PRO llij_lc, xlat,xlon,xi,yj, truelat1, truelat2, hemi, stdlon,lat1, lon1, knowni, knownj, dx
    
    rad_per_deg =  !pi/180.
    deg_per_rad =  180/!pi
    rebydx = 6370./dx

    deltalon = xlon - stdlon
    IF (deltalon gt +180.) then deltalon = deltalon - 360.
    IF (deltalon lt -180.) then deltalon = deltalon + 360.
    deltalon1 = lon1 - stdlon
    IF (deltalon1 gt +180.) then deltalon1 = deltalon1 - 360.
    IF (deltalon1 lt -180.) then deltalon1 = deltalon1 + 360.
 
    tl1r = truelat1 * rad_per_deg
    ctl1r = COS(tl1r)
    IF (ABS(truelat1-truelat2) gt 0.1) THEN begin
        cone = ALOG10(COS(truelat1*rad_per_deg)) - $
        ALOG10(COS(truelat2*rad_per_deg))
        cone=cone/(ALOG10(TAN((45.0-ABS(truelat1)/2.0)*rad_per_deg))- $
        ALOG10(TAN((45.0 - ABS(truelat2)/2.0) * rad_per_deg)))        
    endif else begin
        cone = SIN(ABS(truelat1)*rad_per_deg )  
    ENDelse

    rm = rebydx * ctl1r/cone * $
      (TAN((90.*hemi-xlat)*rad_per_deg/2.) / $
       TAN((90.*hemi-truelat1)*rad_per_deg/2.))^cone
 
    arg = cone*(deltalon*rad_per_deg) 
    arg1 = cone*(deltalon1*rad_per_deg) 

    rsw = rebydx * ctl1r/cone * $
      (TAN((90.*hemi-lat1)*rad_per_deg/2.) / $
       TAN((90.*hemi-truelat1)*rad_per_deg/2.))^cone
   
      polei = hemi*knowni - hemi * rsw * SIN(arg1)
      polej = hemi*knownj + rsw * COS(arg1)  
      xi = polei + hemi * rm * SIN(arg)
      yj = polej - rm * COS(arg)

      xi = hemi * xi
      yj = hemi * yj



END
