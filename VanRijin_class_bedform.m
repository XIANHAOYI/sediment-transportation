function [bedform,blength,bheight] = VanRijin_class_bedform(D50,D90,Um,h,S0,rouw,rous,v)
    % constants
    if isempty(rouw) 
        rouw=1000;     
    end
    if isempty(rous)
        rous=2650;
    end
    if isempty(v)
        v=10^(-6);
    end
    g=9.81;

    % Bedform
    BedF(1).name='mini ripples';
    BedF(2).name='mega ripples & dunes';
    BedF(3).name='dunes';
    BedF(4).name='washed-out dunes or sand waves';
    BedF(5).name='symmetrical sand waves';
    BedF(6).name='plane bed or anti-dunes';

    % Bed-shear stress parameter T
    S=(rous-rouw)/rouw;
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
    ks1=3*D90;
    
    % 如果坡度为空，则使用chezy计算底剪切应力
    % 如果坡度不为空，则使用Ux计算底剪切应力
    if isempty(S0)
        cp=18*log10(12*h/ks1);
        % ks=ks1+ks2,ks2=f(T);ks2与bedform有关,本函数不讨论此情况
        tbp=rouw*g*(Um/cp)^2;
    else
        Ux=sqrt(g*h*S0);
        tbp=rouw*Ux^2;
    end
    T=(tbp-tcrp)/tcrp;
    Fr=Um/sqrt(g*h);

    if T>=0 && T<=10
        if T<=3 && Dx>=1 && Dx<=10
            bedform=BedF(1).name;
            blength=1000*D50;
            bheight=blength/7;
        elseif T<=3 && Dx>10
            bedform=BedF(3).name;
            blength=7.3*h;
            bheight=h*0.11*(D50/h)^0.3*(1-exp(-0.5))*(25-T);
        elseif Dx>=1 && Dx<=10
            bedform=BedF(2).name;
            blength=0.5*h;
            bheight=h*0.02*(1-exp(-0.1*T))*(10-T);
        else
            bedform=BedF(3).name;
            blength=7.3*h;
            bheight=h*0.11*(D50/h)^0.3*(1-exp(-0.5))*(25-T);
        end
    elseif T<=15
        bedform=BedF(3).name;
        blength=7.3*h;
        bheight=h*0.11*(D50/h)^0.3*(1-exp(-0.5))*(25-T);
    elseif T<25
        bedform=BedF(4).name;
        blength=7.3*h;
        bheight=h*0.11*(D50/h)^0.3*(1-exp(-0.5))*(25-T);
    elseif Fr<0.8
        bedform=BedF(5).name;
        blength=10*h;
        bheight=0.15*h*(1-exp(-0.5*(T-15)))*(1-Fr^2);
    else
        bedform=BedF(6).name;
        bheight=0;
        blength=0;
    end

end