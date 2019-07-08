function RunMCMC(nos,w,rrate,rrate_std,xbar_std,sig_std,modelType)

%% Starting parameters
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
xbar = 5.23;    % in 10^22 A m^2
D = 0.3403;     % in 10^44 A^2 m^4 / kyr
g = 0.075;      % in 1/kyr
Ts = 2.5;       % in kyr
a = 20;         % in 1/kyr
% combine in parameter vector
theta = [xbar D g Ts a]';
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-


%% MCMC Hammer
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% Initial ensemble
s = 0.5;
theta_init = MakeInitialEnsemble(s,theta);

% Prior -> enforces parameter bounds
logprior =@(theta) MyPrior(theta);

%% Feature-based likelihood
logLike=@(theta) -Feature_LogLike(theta,w,rrate,rrate_std,xbar_std,sig_std,modelType);

%% Hammer time...
[Theta,logp]=gwmcmc(theta_init,{logprior logLike},nos,'ThinChain',1,'burnin',0);
Filename = strcat('Results_Config_',num2str(w(1)),num2str(w(2)),num2str(w(3)),num2str(w(4)), ...
                    '_RevRate_',num2str(rrate),'_RevRateSTD_',num2str(rrate_std),...
                    '_xbarSTD_',num2str(xbar_std),...
                    '_sigSTD_',num2str(sig_std),...
                    '_ModelType_',num2str(modelType),...
                    '_NOS_',num2str(nos),'.mat');
save(Filename, 'Theta','logp')
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-




