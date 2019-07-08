%%
clear 
close all
clc
colors

%% Default parameters
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
xbar = 5.23;    % in 10^22 A m^2
D = 0.3403;     % in 10^44 A^2 m^4 / kyr
g = 0.075;      % in 1/kyr
Ts = 2.5;       % in kyr
a = 5;         % in 1/kyr
% combine in parameter vector
theta = [xbar D g Ts a]';
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-

%% Myr model
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
T = 2;
[xNonLin,xNonLinS,t] = RunMyrModel(T*1e3,theta,1);
subplot(211)
MyPlotLine(t-T,xNonLin,2,2,'-')
hold on,MyPlotLine(t-T,xNonLinS,6,2,'-')
axis([-2 0 -12 10])
ylabel('VADM (10^{22} A m^2)')

load myPADM2M.mat
load mySint2000.mat
subplot(211)
hold on, MyPlotLine(tPADM2M,dipolePADM2M,4,2,'-')
hold on, MyPlotLine(tSint2000,dipoleSint2000,5,2,'-')
axis([-2 0 -12 10])
xlabel('Time (Myr)')
ylabel('VADM (10^{22} A m^2)')

%% Power spectral density
T = 50;
[xNonLin,xNonLinS,t] = RunMyrModel(T*1e3,theta,1);
[psdXNonLinS, f] = pspectrum(abs(xNonLinS), 1);
[psdXNonLin, f] = pspectrum(abs(xNonLin), 1);

figure(2)
subplot(121)
MyPlotLine(f,psdXNonLin,2,2,'-')
hold on,MyPlotLine(f,psdXNonLinS,6,2,'-')
set(gca,'YScale','log')
set(gca,'XScale','log')
xlabel('Frequency (cycles/kyr)')
ylabel('Power (10^{44} A^2 m^4 kyr)')

%% Compare with theoretical spectra
S1 = 2*D./(g^2+4*pi^2*f.^2);
fTF = exp(-4*pi^2*f.^2*Ts^2/24);
S2 = S1.*(fTF.^2);
hold on, MyPlotLine(f,S1,2,2,'--')
hold on, MyPlotLine(f,S2,6,2,'--')


load myPADM2Mpsd.mat
load mySint2000psd.mat
hold on, MyPlotLine(fPADM2M,psdPADM2M,4,2,'-')
hold on, MyPlotLine(fSint,psdSint,5,2,'-')
axis([fSint(2) fSint(end) 1e-8 3e2])

% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-



%% kyr model
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
[X,Xcn,Y,t] = RunCALS10k2Model(theta,1);
figure(1)
subplot(212)
MyPlotLine(t-10,X,1,2,'-')
hold on,MyPlotLine(t-10,Xcn,7,2,'-')
xlabel('Time (kyr)')
ylabel('VADM (10^{22} A m^2)')

load myCALS10k.mat
hold on, MyPlotLine(tCALS10k*1e3,-dipoleCALS10k,3,2,'-')

%% Power spectral density
[psdX, f]   = pspectrum(abs(X), 1000);
[psdXcn, f] = pspectrum(abs(Xcn), 1000);

figure(2)
subplot(122)
hold on,MyPlotLine(f,psdX,11,2,'-')
hold on,MyPlotLine(f(1:end),psdXcn(1:end),7,2,'-')
set(gca,'YScale','log')
set(gca,'XScale','log')
axis([f(1) f(end) 1e-2 3e2])
xlabel('Frequency (cycles/kyr)')
ylabel('Power (10^{44} A^2 m^4 kyr)')



%% Compare with theoretical spectra
load CALS10kpsd.mat
f = fCALS10k;
S1 = 2*D./(g^2+4*pi^2*f.^2);
S2 = (S1*a^2)./(a^2+4*pi^2*f.^2);

hold on, MyPlotLine(f,S1,2,2,'--')
hold on, MyPlotLine(f,S2,7,2,'--')

%% CALS10k.2
load CALS10kpsd.mat
hold on, MyPlotLine(fCALS10k,psdCALS10k,3,2,'-')
axis([fCALS10k(2) 1e2 1e-8 3e2])
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-

