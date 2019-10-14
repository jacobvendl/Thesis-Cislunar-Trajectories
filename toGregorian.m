%Jake Vendl

function [yr,d] = toGregorian(JD)

    T1900 = (JD - 2415019.5)/365.25;
    yr = 1900+floor(T1900);
    LeapYrs = floor((yr-1900-1)*.25);
    days = (JD - 2415019.5) - ((yr-1900)*365.0 + LeapYrs);
    if days <1.0
        yr = yr-1;
        LeapYrs = floor((yr-1900-1)*0.25);
        days = (JD-2415019.5)-((yr-1900)*365.0+LeapYrs);
    end
    if mod(yr,4) == 0
        LMonth(2)=29;
    end
    d = floor(days);
    
end

