function qb=bedload_BG(rous,rouw,h,S0,Um)
g=9.81;
tb=rouw*g*h*S0;
e=0.1;
tanphi=0.6;
beta=atan(S0);
qb=e*tb*Um/(rous-rouw)/g/cos(beta)/(tanphi-tan(beta));
end