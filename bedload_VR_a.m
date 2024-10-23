function qb=bedload_VR_a(Um,h,D50,D90)
g=9.81;
rouw=1000;rous=2650;
S=rous/rouw;
k=((S-1)*g*D50)^0.5;
if D50>0.1*10^(-3) && D50<0.5*10^(-3)
    Ucr=0.19*D50^0.1*log10(12*h/3/D90);
    qb=0.005*Um*h*((Um-Ucr)/k)^2.4*(D50/h)^1.2;
elseif D50<=2*10^(-3)
    Ucr=8.5*D50^0.6*log10(12*h/3/D90);
    qb=0.005*Um*h*((Um-Ucr)/k)^2.4*(D50/h)^1.2;
else
    qb=nan;
    disp('Could not use this method because sediment size is too large.');
end