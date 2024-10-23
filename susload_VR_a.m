function qs=susload_VR_a(Um,D50,h,D90,Dx)
g=9.81;
rouw=1000;rous=2650;
S=rous/rouw;
k=((S-1)*g*D50)^(1/2);

if D50>=0.1*10^(-3) && D50<0.5*10^(-3)
    Ucr=0.19*D50^(0.1)*log10(4*h/D90);
    qs=0.012*Um*h*((Um-Ucr)/k)^2.4*(D50/h)*Dx^(-0.6);    
elseif D50>=0.5*10^(-3) && D50<2*10^(-3)
    Ucr=8.5*D50^(0.6)*log10(4*h/D90);
    qs=0.012*Um*h*((Um-Ucr)/k)^2.4*(D50/h)*Dx^(-0.6);    
else
    qs=nan;
    disp('The sediment size is too large.');
end
end