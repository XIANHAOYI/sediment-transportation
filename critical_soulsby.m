function theta2=critical_soulsby(Dx)
% soulsby and whitehouse formula (1997)
theta2=0.24/Dx+0.055*(1-exp(-0.020*Dx));
end