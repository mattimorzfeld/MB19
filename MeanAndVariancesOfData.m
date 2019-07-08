%%
clear
close all
clc

load myPADM2M.mat
varPADM2M = var(abs(dipolePADM2M));
stdPADM2M = std(abs(dipolePADM2M));
meanPADM2M = mean(abs(dipolePADM2M));

load mySint2000.mat
varSint2000 = var(abs(dipoleSint2000));
stdSint2000 = std(abs(dipoleSint2000));
meanSint2000 = mean(abs(dipoleSint2000));

% mean([varPADM2M varSint2000])
mean([stdPADM2M stdSint2000])
mean([meanPADM2M meanSint2000])

