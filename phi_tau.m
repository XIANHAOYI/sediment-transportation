function [PHI_taub,error,Ks1]=phi_tau(Ub,Ab,D90,D50)
% wave transportation: Ks=Ks'+Ks''
rouw=1000;rous=2650;
g=9.81;

Ks1=3*D90;
fw=0.3*(Ab/Ks1)^(-0.52);% 待定
taub=1/2*rouw*fw*Ub^2;
PHI=taub/((rous-rouw)*g*D50);
error=1;
if PHI>=1
    while error>=1*10^(-3)
        Ks1=3*PHI*D90;
        fw=0.3*(Ab/Ks1)^(-0.52);
        taub=1/2*rouw*fw*Ub^2;
        PHI2=taub/((rous-rouw)*g*D50);
        error=PHI-PHI2;
        PHI=1/2*(PHI+PHI2);
    end
end
PHI_taub=PHI;
end