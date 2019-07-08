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
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- 1-o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
T = 10000;
[xNonLin,xNonLinS,t] = RunMyrModel(T*1e3,theta,3);
subplot(211)
MyPlotLine(t-T,xNonLin,2,2,'-')
hold on,MyPlotLine(t-T,xNonLinS,6,2,'-')
% axis([-2 0 -12 10])
ylabel('VADM (10^{22} A m^2)')

fprintf('Time average: %g\n',mean(abs(xNonLin)))
fprintf('Time average, smoothed: %g\n',mean(abs(xNonLinS)))
fprintf('xbar: %g\n',xbar)
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-


%% Myr model
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- 1-o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
T = 2;
nexps = 1e3;
XBarEst=zeros(nexps,1);
XBarEstS=zeros(nexps,1);

for kk=1:nexps
    [xNonLin,xNonLinS,t] = RunMyrModel(T*1e3,theta,1);
    XBarEst(kk) = mean(abs(xNonLin));
    XBarEstS(kk) = mean(abs(xNonLinS));
end

fprintf('mean xbar %g\n',mean(XBarEst))
fprintf('std xbar %g\n',std(XBarEst))

fprintf('mean xbar, smoothed %g\n',mean(XBarEst))
fprintf('std xbar, smoothed %g\n',std(XBarEst))

% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-

