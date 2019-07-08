%%
clear
close all
clc

% nos = 1e5;
% w = [1 1 1 0];
% rrate = 4.23;
% rrate_std = 0.1;
% std_std = 1;
% modelType = 1;

%RunMCMC(nos,w,rrate,rrate_std,xbar_std,sig_std,modelType)
RunMCMC(1e5,[1 1 1 1],4.23,0.1,0.024,0.018,1)