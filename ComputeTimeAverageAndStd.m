%%
clear 
close all
clc
colors

%% What results do you want to look at?
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
nos = 1e6;
WhichSetUp = 'a';

if WhichSetUp == 'a'
    %% (a) All data, tight constraints
    w = [1 1 1 1];
    rrate = 4.23;
    rrate_std = 0.05;
    xbar_std = .048;
    sig_std = .036;
elseif WhichSetUp == 'b'
    %% (b) No CALS10k.2
    w = [1 1 0 1];
    rrate = 4.23;
    rrate_std = 0.05;
    xbar_std = .048;
    sig_std = .036;
    
elseif WhichSetUp == 'c'
    %% (c) All data, lose constraints
    w = [1 1 1 1];
    rrate = 4.23;
    rrate_std = 0.5;
    xbar_std = .48;
    sig_std = .36;
    
elseif WhichSetUp == 'd'
    %% (d) Only spectral data
    w = [1 0 1 0];
    rrate = 4.23; % meaningless
    rrate_std = 0.5; % meaningless
    xbar_std = .48; % meaningless
    sig_std = .36; % meaningless
    
elseif WhichSetUp == 'e'
    %% (e) Only rev.rate, std and time average data, tight constraints
    w = [0 1 0 1];
    rrate = 4.23;
    rrate_std = .05;
    xbar_std = .048;
    sig_std = .036;
elseif WhichSetUp == 'f'
    %% (g) Only Sint and PADM2M
    w = [1 0 0 0];
    rrate = 4.23; % meaningless
    rrate_std = .5; % meaningless
    xbar_std = .48;% meaningless
    sig_std = .36; % meaningless    
elseif WhichSetUp == 'g'
    %% (f) Only CALS10k.2
    w = [0 0 1 0];
    rrate = 4.23; % meaningless
    rrate_std = .5; % meaningless
    xbar_std = .48;% meaningless
    sig_std = .36; % meaningless
end

modelTypeForEstimation = 1;
modelTypeForSimulation = 1;  % can be 1 or 3 if modelTypeForEstimation = 1
                             % must be 2 if modelTypeForEstimation = 2
LoadAndRemoveBurnIn  

xm = mean(X,2);

T1  = 0.78*1e3;
T2  = 1.22*1e3;
T3 = 2*1e3;
nos = 1e4;
xbar_T1 = zeros(nos,1);
xbar_T2 = zeros(nos,1);
xbar_T3 = zeros(nos,1);
std_T3 = zeros(nos,1);

for kk=1:nos
    [x,xs,~] = RunMyrModel(T1,xm,1);
    xbar_T1(kk) = mean(abs(xs));
    
    [x,xs,~] = RunMyrModel(T2,xm,1);
    xbar_T2(kk) = mean(abs(xs));
    
    [x,xs,~] = RunMyrModel(T3,xm,1);
    xbar_T3(kk) = mean(abs(xs));
    std_T3(kk) = std(abs(xs));
end

std(xbar_T1-xbar_T2)

%%
tic
[x,xs,~] = RunMyrModel(10*1000*1e3,xm,1);
toc