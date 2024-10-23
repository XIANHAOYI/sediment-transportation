function ws = fall_velocity(T,D50,sigmas,v)
rouw=1000;rous=2650;
g=9.81;
S=rous/rouw;

if isempty(sigmas)%
    Dx=D50*(g*(S-1)/v^2)^(1/3);
    ws=v/D50*((10.36^2+1.049*Dx^3)^(1/2)-10.36);
else
    if T>25
        Ds=D50;
    else
        Ds=D50*(1+0.011*(sigmas-1)*(T-25));
    end

    if Ds<0.1*10^(-3)
        ws=(S-1)*g*Ds^2/18/v;
    elseif Ds<1*10^(-3)
        ws=10*v/Ds*((1+0.01*(S-1)*g*Ds^3/v^2)^0.5-1);
    else
        ws=1.1*((S-1)*g*Ds)^(1/2);
    end
end

end