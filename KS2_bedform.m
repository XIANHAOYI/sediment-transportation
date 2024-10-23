function ks2=KS2_bedform(PHI,theta,bedform,blength,bheight)
% theta: critical shields parameter
% only ripples and dunes have ks2

if PHI>theta && PHI<1
    if strcmp(bedform,'mini ripples')||strcmp(bedform,'mega ripples and dunes')
        ks2=400*D50;
    elseif strcmp(bedform,'dunes')
        ks2=1.1*0.7*bheight*(1-exp(-25*bheight/blength));
    else
        ks2=0;
    end
else
    ks2=0;
end
end