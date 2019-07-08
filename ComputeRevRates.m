%%
clear 
close all
clc

%% compute a reversal rate
xbar = 7.64;
g = 0.1;
s = 2.72;

rr = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3

%% compute a standard deviation
clear 
xbar = 5.23;
rr= 4.27;
g = 0.1;
s = xbar/sqrt(-log(rr/(g/2/pi)/1e3)*6)


%% Standard deviation
% clear
% close all
% clc
% xbar = 5.23;
% D = 0.3403;
% g = 0.075;
% Ts = 2.5;
% a = 5;
% 
% CorrectionFactor = exp((g*Ts)^2 /12) *erfc(g*Ts/2/sqrt(3));
% s  = sqrt(D/g*CorrectionFactor)
% rr = (g/2/pi)*exp(-(g*xbar^2)/D/6)*1e3
