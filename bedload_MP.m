function bedload = bedload_MP(D50,D90,h,Um,Dm)
Ks=3*D90;
rouw=1000;rous=2650;
s=rous/rouw;
g=9.81;

c=18*log10(12*h/Ks);
Ux=sqrt(g)*Um/c;
phi=Ux^2/((s-1)*g*D50);

if isempty(Dm)
    Dm=1.2*D50;
end
phi_cr=0.047;
bedload=8*(phi-phi_cr)^(3/2)*((s-1)*g*Dm^3)^0.5;
end