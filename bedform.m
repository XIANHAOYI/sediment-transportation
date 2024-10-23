function [bedform,bheight,blength]=bedform(T,Dx,h,Um,D50)
g=9.81;
Fr=Um/sqrt(g*h);

if T>=0 && T<=10
    if T<=3 && Dx>=1 && Dx<=10
        bedform='mini ripples';
        blength=1000*D50;
        bheight=blength/7;
    elseif T<=3 && Dx>10
        bedform='dunes';
        blength=7.3*h;
        bheight=h*0.11*(D50/h)^0.3*(1-exp(-0.5*T))*(25-T);
    elseif Dx>=1 && Dx<=10
        bedform='mega ripples and dunes';
        blength=0.5*h;
        bheight=h*0.02*(1-exp(-0.1*T))*(10-T);
    else
        bedform='dunes';
        blength=7.3*h;
        bheight=h*0.11*(D50/h)^0.3*(1-exp(-0.5*T))*(25-T);
    end
elseif T<=15
    bedform='dunes';
    blength=7.3*h;
    bheight=h*0.11*(D50/h)^0.3*(1-exp(-0.5*T))*(25-T);
elseif T<25
    bedform='washed-out dunes, sand waves';
    blength=7.3*h;
    bheight=h*0.11*(D50/h)^0.3*(1-exp(-0.5*T))*(25-T);
elseif Fr<0.8
    bedform='symmetrical sand waves';
    blength=10*h;
    bheight=0.15*h*(1-exp(-0.5*(T-15)))*(1-Fr^2);
else
    bedform='plane bed or antidunes';
    bheight=0;
    blength=0;
end

end