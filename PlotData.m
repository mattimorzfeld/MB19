%%
clear 
close all
clc
colors

%% Sint-2000 and PADM2M
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
load myPADM2M.mat
load mySint2000.mat
figure(1)
subplot(211)
MyPlotLine(tPADM2M,abs(dipolePADM2M),4,2,'-')
hold on, MyPlotLine(tSint2000,abs(dipoleSint2000),5,2,'-')
axis([-2 0 0 12])
xlabel('Time (Myr)')
ylabel('VADM (10^{22} A m^2)')


load myPADM2Mpsd.mat
load mySint2000psd.mat
figure(2)
hold on, MyPlotLine(fPADM2M,psdPADM2M,4,2,'-')
hold on, MyPlotLine(fSint,psdSint,5,2,'-')
xlabel('Frequency (cycles/kyr)')
ylabel('Power (10^{44} A^2 m^4 kyr)')
axis([5e-4 1e2 1e-8 120])
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-



%% CALS10k.2
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
load myCALS10k.mat
figure(1)
subplot(212)
hold on, MyPlotLine(tCALS10k*1e3,-dipoleCALS10k,3,2,'-')
xlabel('Time (kyr)')
ylabel('VADM (10^{22} A m^2)')


%% CALS10k.2
load CALS10kpsd.mat
figure(2)
hold on,MyPlotLine(fCALS10k,psdCALS10k,3,2,'-')
set(gca,'YScale','log')
set(gca,'XScale','log')
xlabel('Frequency (cycles/kyr)')
ylabel('Power (10^{44} A^2 m^4 kyr)')
axis([fSint(1) 1e2 1e-8 3e2])
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-

