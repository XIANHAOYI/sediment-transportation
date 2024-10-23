function qs=susload_BG(h,S0,Um,v,Dx,D50)
es=0.02;
eb=0.1;
beta=atan(S0);
rouw=1000;rous=2650;
g=9.81;

tb=rouw*g*h*S0;
ws=v/D50*((10.36^2+1.049*Dx^3)^(1/2)-10.36);
qs=es*(1-eb)*tb*Um/((rous-rouw)*g*cos(beta)*(ws/Um-tan(beta)));
end