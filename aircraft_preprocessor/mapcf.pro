; adapted from fortran suroutine MAPCF by G. Frost
; computes the lat and lon from model indexes of 
; a point; Lambert  Conformal Projection
; Gabriele Pfister 2004
; this one is needed for NEI emissions

PRO MAPCF, xi, yj, xlat, xlon

dxkm = 4. 
xlatc = 40.
xlonc = -97.
il = 1369.
jl = 1045
clat1 = 45. 
clat2 = 33.
A = 6370.997
pole = 90.
count=0L

frty5d = atan(1.)
conv = 45./frty5d
rlat1 = clat1/conv
rlat2 = clat2/conv
xn = alog(cos(rlat1)/cos(rlat2))/alog(tan(frty5d+.5*rlat2)/tan(frty5d+.5*rlat1))
psx = (pole-xlatc)/conv
cell = a*sin(rlat1)/xn
cell2 = (tan(psx/2.))/(tan(rlat1/2.))
R = cell*(cell2^xn)
cntrj = (jl+1)/2.
cntri = (il+1)/2.
rxn = 1.0/xn

x = (xi-cntri)*dxkm
y = (yj-cntrj)*dxkm-R

FLP = ATAN(-1*x/y)
FLPP = (FLP/XN)*CONV+xlonc
IF (FLPP LT -180) THEN FLPP = FLPP + 360.
IF (FLPP GT 180) THEN FLPP = FLPP-360.
xlon=FLPP

zzzz = x*y+y*y
rs = SQRT(X*X+y*Y)
cell = (rs*xn)/(a*sin(rlat1))
cel1 = tan(rlat1/2.)*(cell^rxn)
cel2 = atan(cel1)
psx = 2*cel2*conv
xlat = pole-psx


END
