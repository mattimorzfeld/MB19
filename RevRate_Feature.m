function loglikerr = RevRate_Feature(xbar,D,g,rrate,rrate_std,modelType)
s  = sqrt(D/g);

if modelType == 1
    rr = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3; % in Myr
elseif modelType==2
    rr = (g/2/pi)*exp(-(xbar/s)^2*(13/64))*1e3; % in Myr
else
    error('unknown model type')
end
loglikerr =.5*((rr-rrate)/rrate_std)^2;

