function [theta1,Dx]=critical_shields(D50,rous,rouw,v)
g=9.81;
% S
S=rous/rouw;
% Dx
Dx=D50*((S-1)*g/v^2)^(1/3);

if Dx>1 && Dx<=4
    Pcr=0.24*Dx^(-1);
elseif Dx>4 && Dx<=10
    Pcr=0.14*Dx^(-0.64);
elseif Dx>10 && Dx<=20
    Pcr=0.04*Dx^(-0.1);
elseif Dx>20 && Dx<=150
    Pcr=0.013*Dx^(0.29);
else 
    Pcr=0.055;
end
theta1=Pcr;
end