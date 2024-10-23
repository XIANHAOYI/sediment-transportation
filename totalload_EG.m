function qt=totalload_EG(Um,rouw,rous,D50,C)
g=9.81;
S=rous/rouw;
qt=0.05*Um^5/((S-1)^2*g^0.5*D50*C^3);
end