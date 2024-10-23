function qs=susload_VR_c(Um,h,D50,D90,v,S0,Sigmas)
rouw=1000;rous=2650;
g=9.81;
S=rous/rouw;
[theta,Dx]=critical_shields(D50,rous,rouw,v);
tbcr=theta*(rous-rouw)*g*D50;
ks1=3*D90;

Ux=sqrt(g*h*S0);
PHI=Ux^2/((S-1)*g*D50);
c1=18*log10(12*h/ks1);% sediment size induced c
tb1=rouw*g*(Um/c1)^2;
T=(tb1-tbcr)/tbcr;
[bedtype,bheight,blength]=bedform(T,Dx,h,Um,D50);
ks2=KS2_bedform(PHI,theta,bedtype,blength,bheight);
ks=ks1+ks2;
% C=18*log10(12*h/ks);
a=[ks,bheight/2,0.01*h];
a=max(a);
Ca=0.015*D50/a*T^1.5/Dx^0.3;

ws=fall_velocity(T,D50,Sigmas,v);
if ws/Ux>0.5
    beta=1.5;
elseif ws/Ux>0.1
    beta=1+2*(ws/Ux)^2;
end
k=0.4;
Z=ws/(beta*k*Ux);

C0=0.65;
if ws>Ux
    psi=0;
elseif ws/Ux>=0.01
    psi=2.5*(ws/Ux)^0.8*(Ca/C0)^0.4;
end

Z2=Z+psi;
F=((a/h)^Z2-(a/h)^1.2)/((1-a/h)^Z2*(1.2-Z2));
qs=F*Um*h*Ca;
end