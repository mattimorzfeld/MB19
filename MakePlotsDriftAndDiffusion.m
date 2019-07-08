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

%% Plot drift
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
x = -12:.01:12;
f=zeros(size(x));
U = zeros(size(x));
for kk=1:length(x)
    f(kk) = v(x(kk),theta,1);
    U(kk) = PotU(x(kk),g,xbar);
end
MyPlotLine(x,f,2,2,[])
hold on,MyPlotLine(x,U,1,2,[])
xlabel('VADM (10^{22} A m^2)')
ylabel('Amplitude')
axis([-12 12 -1 3])
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-




