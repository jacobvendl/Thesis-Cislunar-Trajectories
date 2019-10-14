%Jake Vendl

function output = toJD(yr,mo,d,h,mn,s)

output = 367*yr - round(7*(yr + round((mo+9)/12))/4) +...
    round(275*mo/9) + d + 1721014.5 + ((s/60+mn)/60+h)/24;
end

