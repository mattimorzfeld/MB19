%%
clear 
close all
clc
colors

%% What results do you want to look at?
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
nos = 1e6;
WhichSetUp = 'f';

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

% Plot histogram of F
figure,hist(F,100)
set(gcf,'Color','w')
set(gca,'FontSize',20)
box off
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-



%% Cut off samples with small F
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% [tmpa,tmpb]=find(F>-600);
% X = X(:,tmpa);
% F = F(tmpa);
% figure,hist(F,100)
% set(gcf,'Color','w')
% set(gca,'FontSize',20)
% box off
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-

%% Triangle plot
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
close all
TrianglePlot(X,1)
subplot(551)
xlabel('in 10^{22} A m^2')
subplot(557)
xlabel('D in 10^{44} A^2 m^4 / kyr')
subplot(5,5,13)
xlabel('\gamma in 1/kyr')
subplot(5,5,19)
xlabel('T_s in kyr')
subplot(5,5,25)
xlabel('a in 1/kyr')
clc
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-



%% Compute and print posterior mean and standard deviation
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
xm = mean(X,2)';
xm = [xm];
xstd = std(X');
xstd = [xstd];
name = cell(5,1);
name{1} = 'xbar';name{2} = 'D';name{3} = 'gamma';
name{4} = 'Ts';name{5} = 'a';%name{6} = 'sigma';
for kk=1:length(xm)
    fprintf(strcat(name{kk},' = ') )
    fprintf(' %g pm %g \n',xm(kk),xstd(kk))
end
disp(' ')
disp(' ')
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-

%% Reversal rate and Sigma
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
ComputeRevRateAndSigma
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-




%% Plot PSDs and approxiamte reversal rate
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
PlotPSDs, drawnow
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-

if 0

%% Plot PSDs from short model runs
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
PlotPSDFromTimeDomainSims
% axis([2e-4 1e3 1e-11 5e2])
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-

%% Plot model runs in time domain
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
TimeDomainPlots
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-

end
