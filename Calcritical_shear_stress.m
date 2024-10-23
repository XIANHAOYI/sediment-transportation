function critical_stress = Calcritical_shear_stress(rous,rouw,D50,Di,beta,gama)
% considerating the hiding factor, bed slope and transversal slope
% rous---sediment density
% rouw---water density
% D50---median grain size，unit:m
% Di---diameter of the particle, unit:m
% beta---bed slope, 含正负, unit:dge
% gama---transversal slope, 含正负, unit:dge

% contants by deflaut
g=9.81;
v=10^(-6);
% S
S=(rous-rouw)/rouw;
% Dx
Dx=D50*((S-1)*g/v^2)^(1/3);
if Dx<=4
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
tcrp=Pcr*(rous-rouw)*g*D50;
critical_stress=tcrp;
if Di==0 && beta==0 && gama==0
    disp('There is no hiding factor, bed slope and transversal slope.');
    disp(['The critical bed shear stress is',num2str(critical_stress)]);
end

if Di
    disp('There is hiding and exposure effect in sediment transport.');
    xi=(log10(19)/log10(19*Di/D50))^(2);
    critical_stress=xi*tcrp;
end

if beta
    disp('There is bed-slope effect in sediment transport.');
    if D50>=0.1
        APhi=[40,45];
    elseif D50>=0.05
        APhi=[37,42];
    elseif D50>=0.01
        APhi=[35,40];
    elseif D50>=0.005
        APhi=[32,37];
    else
        APhi=[30,35];
    end
    Q='Is the material rounded or angular? 1 for rounded and 0 for angular';
    phi=str2num(input(Q));
    switch phi
        case 1
            phi=APhi(1);
        case 0
            phi=APhi(2);
    end
    KB=sin((phi-beta)/180*pi)/sin(phi/180*pi);
    critical_stress=KB*tcrp;
end

if gama
    disp('There is transversal slope effect in sediment transport.');
    if D50>=0.1
        APhi=[40,45];
    elseif D50>=0.05
        APhi=[37,42];
    elseif D50>=0.01
        APhi=[35,40];
    elseif D50>=0.005
        APhi=[32,37];
    else
        APhi=[30,35];
    end
    Q='Is the material rounded or angular? 1 for rounded and 0 for angular';
    phi=str2num(input(Q));
    switch phi
        case 1
            phi=APhi(1);
        case 0
            phi=APhi(2);
    end
    Kg=cos(gama/180*pi)*sqrt(1-tan(gama/180*pi)^2/tan(phi/180*pi)^2);
    critical_stress=Kg*tcrp;
end

end