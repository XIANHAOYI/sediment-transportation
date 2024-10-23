function qb=bedload_VR_c(Dx,T,S,D50)
g=9.81;
if T<3
    qb=0.053*Dx^(-0.3)*T^(2.1)*((S-1)*g*D50^3)^(1/2);
else
    qb=0.1*Dx^(-0.3)*T^(1.5)*((S-1)*g*D50^3)^(1/2);
end
end