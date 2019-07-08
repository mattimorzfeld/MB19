function loglikeMeandAndStandDev = MeanAndStandDev_Feature(xbar,D,g,Ts,xbar_std,sig_std)
CorrectionFactor = exp((g*Ts)^2 /12) *erfc(g*Ts/2/sqrt(3));
s  = sqrt(D/g*CorrectionFactor);

loglikeMeandAndStandDev = .5*((s-1.66)/sig_std)^2 ...
                            + .5*((5.56-xbar)/xbar_std)^2;
