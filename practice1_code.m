% practice 1
% problem 1
% constants
Ks=0.05;
D50=0.05;
rous=2650;
rouw=1000;
v=1.0*10^(-6);
T=20;
g=9.81;
h=2;
b=15;
a=0.75;% slope factor, to calculate shear stress in slide
r=atan(1/2);% transversal slope angle, unit: rad
fai=37/180*pi;% angle of repose ф, unit: rad
A=(15+(15+4*2))*h/2;% wetted area
C=15+2*sqrt(4^2+2^2);% wetted perimeter
R=A/C;% hydraulic radius

% critical shear stress in  bottom
[theta1,Dx]=critical_shields(D50,rous,rouw,v);
theta2=critical_soulsby(Dx);
theta=min(theta1,theta2);
tbcr0=theta*(rous-rouw)*g*D50;

% critical shear stress in slide
kr=cos(r)*(1-tan(r)^2/tan(fai)^2)^(1/2);
tbcr_slide=kr*tbcr0;

% bottom slope S0
S01=tbcr0/(rouw*g*h);
S02=tbcr_slide/(a*rouw*g*h);
S0=min(S01,S02);

% flow rate Q
tb=rouw*g*h*S0;
Ux=sqrt(tb/rouw);
c=chezy(Ux,Ks,v,h);
Q=A*c*sqrt(R*S0);
%%
clc,clear
% problem 2
% constant
Um=1.4;
S0=8*10^(-4);
rouw=1000;
rous=2650;
v=10^(-6);
D50=0.7*10^(-3);
D90=1.5*10^(-3);
Dm=0.8*10^(-3);
Sigmas=2.5;
g=9.81;
S=rous/rouw;
% critical shear stress in  bottom
[theta1,Dx]=critical_shields(D50,rous,rouw,v);
tbcr=theta1*(rous-rouw)*g*D50;

% calculate h
% calculate T obtain bedform information
% then use result obtain new c
% using relationship of c and Um,verify h
ks1=3*D90;
h_0=1:0.01:1.5;

delta_h=zeros(1,length(h_0));
c=zeros(1,length(h_0));
ks=zeros(1,length(h_0));

for i=1:length(h_0)
    h=h_0(i);
    Ux=sqrt(g*h*S0);
    PHI=Ux^2/((S-1)*g*D50);
    if PHI>=1
        ks1=ks1*PHI;
    end
    c1=chezy(Ux,ks1,v,h);% sediment size induced c
    tb1=rouw*g*(Um/c1)^2;
    T=(tb1-tbcr)/tbcr;
    [bedtype,bheight,blength]=bedform(T,Dx,h,Um,D50);
    ks2=KS2_bedform(PHI,theta1,bedtype,blength,bheight);
    ks(i)=ks1+ks2;
    c(i)=chezy(Ux,ks(i),v,h);
    h_n=(Um/c(i))^2/S0;
    % error ~0.1%
    delta_h(i)=h_n-h;
end
delta_h=abs(delta_h);
[error,n]=min(delta_h);
h=h_0(n);
error=error/h*100;
figure(1)
plot(h_0,delta_h/h*100,'LineWidth',1.5);
xlabel('water depth(m)');
ylabel('relative error(%)');
title(['Water depth is ',num2str(h),' m with error is ',num2str(error),'%.']);
set(gca,'FontName','Times New Roman','FontSize',12);
grid on
disp(['Water depth is ',num2str(h),' m, the error is ',num2str(error),'%.']);

% calculate flow rate Q
tb=rouw*g*h*S0;
Ux=sqrt(tb/rouw);
C=c(n);
B=h*5;% river width
A=B*h;% river cross area
Q=A*C*sqrt(h*S0);

%% calculate sediment transportation
h=1.27;
Ux=sqrt(g*h*S0);
PHI=Ux^2/((S-1)*g*D50);
ks1=3*D90;
if PHI>=1
    ks1=ks1*PHI;
end
c1=chezy(Ux,ks1,v,h);% sediment size induced c
tb1=rouw*g*(Um/c1)^2;
T=(tb1-tbcr)/tbcr;

% calculate bed load by Van Rijn formula (complete)
qb1=bedload_VR_c(Dx,T,S,D50);
% calculate bed load by Van Rijn formula (approximation)
qb2=bedload_VR_a(Um,h,D50,D90);
% calculate bed load by Meyer-Peter
qb3=bedload_MP(D50,D90,h,Um,Dm);
% calculate bed load by Bagnold
qb4=bedload_BG(rous,rouw,h,S0,Um);

color1=[131 111 255]/255;
% compare different sediment bed load
y = [qb1,qb2,qb3,qb4];
subplot(1,3,1)
bar(y,'FaceColor',color1);
for i = 1:length(y)
    text(i, y(i)+0.2*10^(-4), sprintf('%.2e', y(i)), ...
        'HorizontalAlignment', 'center','FontName','Times New Roman');
end
xticks(1:length(y));  
x_label={'Van Rijn', 'Van Rijn Approximation',... 
    'Meyer-Peter-Mueller', 'Bagnold'};
xticklabels(x_label);       
% xlabel('different formulations');
ylabel('Bed Load Transport(m^3/s*m)');
ylim([0,3*10^(-4)]);
set(gca,'FontName','Times New Roman','FontSize',12);
grid on

% calculate suspended load by complete Van Rijn
qs1=susload_VR_c(Um,h,D50,D90,v,S0,Sigmas);
% calculate suspended load by approximate Van Rijn
qs2=susload_VR_a(Um,D50,h,D90,Dx);
% calculate suspended load by Bagnold
qs3=susload_BG(h,S0,Um,v,Dx,D50);
subplot(1,3,2)
color2=[95 158 160]/255;
y2=[qs1,qs2,qs3];
bar(y2,'FaceColor',color2);
for i = 1:length(y2)
    text(i, y2(i)+0.2*10^(-4), sprintf('%.2e', y2(i)), ...
        'HorizontalAlignment', 'center','FontName','Times New Roman');
end
xticks(1:length(y));  
x_label={'Van Rijn', 'Van Rijn Approximation','Bagnold'};
xticklabels(x_label);       
% xlabel('different formulations');
ylim([0 6*10^(-4)]);
ylabel('Suspended Load Transport(m^3/s*m)');
set(gca,'FontName','Times New Roman','FontSize',12);
grid on

qt1=qb1+qs1;
qt2=qb2+qs2;
qt3=qb4+qs3;
% calculate total load by Engelund
qt4=totalload_EG(Um,rouw,rous,D50,C);
% plot total sediment load
subplot(1,3,3)
color3=[218 165 32]/255;
y3=[qt1,qt2,qt3,qt4];
bar(y3,'FaceColor',color3);
for i = 1:length(y3)
    text(i, y3(i)+0.2*10^(-4), sprintf('%.2e', y3(i)), ...
        'HorizontalAlignment', 'center','FontName','Times New Roman');
end
xticks(1:length(y));  
x_label={'Van Rijn', 'Van Rijn Approximation','Bagnold','Engelund'};
xticklabels(x_label);       
% xlabel('different formulations');
ylim([0 8*10^(-4)]);
ylabel('Total Load Transport(m^3/s*m)');
set(gca,'FontName','Times New Roman','FontSize',12);
grid on
set(gcf,'Position', [100, 300, 1000, 400]);