function c=chezy(Ux,Ks,v,h)
k=Ux*Ks/v;% decide regime

if k<=5
    c=18*log10(12*h/(3.3*v/Ux));
elseif k>=70
    c=18*log10(12*h/Ks);
else
    c=18*log10(12*h/(Ks+3.3*v/Ux));
end

end