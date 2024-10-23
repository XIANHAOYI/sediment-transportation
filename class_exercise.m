% class exercises L2_1
S0=0.5*10^(-3);
h=2;
D50=2*10^(-3);
D90=5*10^(-3);
rous=2650;
rouw=1000;
S=(rous-rouw)/rouw;
g=9.81;v=10^-6;
% calculate Pcr
D1=D50*((S-1)*g/v^2)^(1/3);
D2=25*D50*1000;% 这个有问题
D=D1;
if D<=4
    Pcr=0.24*D^(-1);
elseif D>4 & D<=10
    Pcr=0.14*D^(-0.64);
elseif D>10 & D<=20
    Pcr=0.04*D^(-0.1);
elseif D>20 & D<=150
    Pcr=0.013*D^(0.29);
else 
    Pcr=0.055;
end
Pcr2=0.24/D2+0.055*(1-exp(-0.02*D2));
% calculate tcr
tcr1=Pcr*(rous-rouw)*g*D50;
tcr2=Pcr2*(rous-rouw)*g*D50;
% calculate tb
tb=rouw*g*h*S0;
if tb>tcr1
    disp('Sediment move');
else
    disp('Sediments do not move');
end
%% exercise L2_2
clear,clc
S0=10^(-5);g=9.81;
b=20;
D50=0.2*10^(-3);
D90=0.3*10^(-3);
rous=2650;rouw=1000;S=(rous-rouw)/rouw;
T=20;v=10^(-6);
Dx=D50*((S-1)*g/v^2)^(1/3);

Pcr=0.24/Dx+0.055*(1-exp(-0.02*Dx));
Pcr2=0.24*Dx^(-1);

tcr=Pcr2*(rous-rouw)*g*D50;
h=tcr/(rouw*g*S0);
% 结果与figure所示相差较远
%% exercise L1
clear,clc
S0=10^(-5);D90=0.3*10^(-3);rouw=10^3;g=9.8;
v=10^(-6);
tb=0.18;
h=tb/(rouw*g*S0);
ks=3*D90;
n=0.045*(ks)^(1/6);
c=h^(1/6)/n;
Um=c*(h*S0)^(1/2);% using manning equation

Ux=sqrt(tb/rouw);
Rex=Ux*ks/v;% trantision
c2=18*log10(12*h/(ks+3.3*v/Ux));
Um2=c2*(h*S0)^(1/2);

c3=25*(h/ks)^(1/6);
if 40<=c3 & c3<=70
    disp(['C is',num2str(c3)]);
else
    disp('Can not calculat c by h and ks');
end
%%
h=3;S0=3*10^(-4);
Um=1.5;
D50=0.35*10^(-3);D90=1*10^(-3);g=9.81;
rous=2650;rouw=1000;S=1650/1000;
v=1.01*10^(-6);
cp=18*log10(12*h/3/D90);
tbp=rouw*g*(Um/cp)^2;
Ux=sqrt(tbp/rous);
Rex=Ux*3*D90/v;

Dx=D50*((S-1)*g/v^2)^(1/3);
Pcr=0.24/Dx+0.055*(1-exp(-0.02*Dx));
tcr=Pcr*(rous-rouw)*g*D50;
Fr=Um/sqrt(g*h);
T=(tbp-tcr)/tcr;
deltar=0.15*(1-exp(-0.5*(T-15)))*(1-Fr^2)*h;
%%
Calcritical_shear_stress(2650,1000,0.04,0,0,27);