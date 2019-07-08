%%
clear
close all
clc
colors

load mySint2000.mat
load myPADM2M.mat

load mySint2000psd.mat
load myPADM2Mpsd.mat

T = 2; % 2 Myr runs
Nexps = 5000; 
psd1 = zeros(1001,Nexps);
psd2 = zeros(1001,Nexps);
for kk = 1:Nexps
    fprintf('Experiment %g / %g \r',kk,Nexps)
    tmp1 = dipoleSint2000 + sigSint2000.*randn(size(sigSint2000));
    [psdX1, f] = pspectrum(abs(tmp1), 1);
    psdX1 = interp1(f,psdX1,fSint);
    psd1(:,kk) = psdX1;
    
    tmp2 = dipolePADM2M + sigSint2000.*randn(size(sigSint2000));
    [psdX2, f] = pspectrum(abs(tmp2), 1);
    psdX2 = interp1(f,psdX2,fSint);
    psd2(:,kk) = psdX2;
end

%%
close all
figure
loglog(f,psd1,'Color',[Color(:,4);.1])
hold on,loglog(f,psd2,'Color',[Color(:,5);.1])
% hold on, loglog(fSint,mean([psdSint psdPADM2M]'),'Color',Color(:,2),'LineWidth',2)
% hold on, loglog(fSint,psdSint,'Color',Color(:,4),'LineWidth',2)
% hold on, loglog(fSint,psdPADM2M,'Color',Color(:,5),'LineWidth',2)
set(gcf,'Color','w')
set(gca,'FontSize',16)
box off
axis([0.0005 fSint(end) 1e-4 5e2])
xlabel('Frequency (cycles/kyr)')
ylabel('Power (10^{44} A^2 m^4 kyr)')


%% vs noise based on shortness of record
% clear
% colors
% load LF_NoiseModel.mat
% load myPADM2Mpsd.mat
% load mySint2000psd.mat
% 
% f_LF_ErrorCloud = f;
% load LF_Noise_Spectra.mat
% 
% figure
% hold on, plot(f_LF_ErrorCloud,X2M(:,1:5000),'Color',[128 128 128]/255)
% 
% hold on,plot(fPADM2M,psdPADM2M,'-','Color',Color(:,4),'LineWidth',2)
% hold on,plot(fSint,psdSint,'-','Color',Color(:,5),'LineWidth',2)
% hold on,plot(f,m,'-','Color',Color(:,2),'LineWidth',2)
% 
% 
% set(gca,'YScale','log')
% set(gca,'XScale','log')
% xlabel('Frequency (cycles/kyr)')
% ylabel('Power (10^{44} A^2 m^4 kyr)')
% set(gca,'FontSize',16)
% set(gcf,'Color','w')
% axis([0.0005 fSint(end) 1e-4 5e2])
