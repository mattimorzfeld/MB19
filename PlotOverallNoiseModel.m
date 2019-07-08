%%
clear
close all
clc


% clear
% load HF_NoiseModel.mat
% load CALS10kpsd.mat
% colors
% 
% nos = 1e4;
% X10k = zeros(length(m),nos);
% for kk=1:nos
%     go = 1;
%     while go == 1
%         tmp = m+L*randn(length(m),1); 
%         if sum(tmp>0)==length(m)
%             X10k(:,kk) = tmp;
%             go = 0;
%         end
%     end
% end
% 
% figure(1)
% plot(fCALS10k(inds),X10k,'Color',Color(:,1))
% set(gca,'YScale','log')
% set(gca,'XScale','log')
% save('HF_Noise_Spectra.mat','X10k')

% MX10k = mean(X10k,2);
% stdX10k = std(X10k')';
% hold on,plot(fCALS10k(inds),MX10k+2*stdX10k','k--')
% hold on,plot(fCALS10k(inds),max(MX10k-2*stdX10k',1e-9*ones(size(MX10k))),'k--')
% myerrorCloud(MX10k,2*stdX10k,fCALS10k(inds),Color(:,2))



%%
% clear
% colors
% load HF_NoiseModel.mat
% load CALS10kpsd.mat
% figure(1)
% hold on,plot(fCALS10k,psdCALS10k,'--','Color',Color(:,3),'LineWidth',1)
% hold on,plot(fCALS10k(inds),psdCALS10k(inds),'Color',Color(:,3),'LineWidth',2)
% 
% clear
% load LF_NoiseModel.mat
% colors
% nos = 1e3;
% X2M = zeros(length(m),nos);
% for kk=1:nos
%     go = 1;
%     while go == 1
%         tmp = m+L*randn(length(m),1); 
%         if sum(tmp>0)==length(m)
%             X2M(:,kk) = tmp;
%             go = 0;
%         end
%     end
% end
% 
% figure(1)
% plot(f,X2M,'Color',Color(:,1))
% 
% % save('LF_Noise_Spectra.mat','X2M')
% % f(1) = 1e-8;
% % MX2M = mean(X2M,2);
% % stdX2M = std(X2M')';
% % % hold on,plot(fCALS10k(inds),MX10k+2*stdX10k','k--')
% % % hold on,plot(fCALS10k(inds),max(MX10k-2*stdX10k',1e-9*ones(size(MX10k))),'k--')
% % myerrorCloud(MX2M,2*stdX2M,f,Color(:,2))
% 
% 
% 
% %
% clear
% colors
% load mySint2000psd.mat
% figure(1)
% hold on,plot(fSint,psdSint,'-','Color',Color(:,5),'LineWidth',2)
% 
% %%
% clear
% colors
% load myPADM2Mpsd.mat
% figure(1)
% hold on,plot(fPADM2M,psdPADM2M,'-','Color',Color(:,4),'LineWidth',2)
% 
% set(gcf,'Color','w')
% set(gca,'FontSize',16)
% box off
% 
% 
% %% 
% clear
% colors
% load LF_NoiseModel.mat
% figure(1)
% hold on,plot(f,m,'-','Color',Color(:,2),'LineWidth',2)

colors
load HF_NoiseModel.mat
load LF_NoiseModel.mat
load CALS10kpsd.mat
load myPADM2Mpsd.mat
load mySint2000psd.mat

f_LF_ErrorCloud = f;
f_HF_ErrorCloud = fCALS10k(inds);
load LF_Noise_Spectra.mat
load HF_Noise_Spectra.mat

hold on, plot(f_LF_ErrorCloud,X2M(:,1:5000),'Color',[128 128 128]/255)
hold on, plot(f_HF_ErrorCloud,X10k(:,1:5000),'Color',[128 128 128]/255)

hold on,plot(fPADM2M,psdPADM2M,'-','Color',Color(:,4),'LineWidth',2)
hold on,plot(fSint,psdSint,'-','Color',Color(:,5),'LineWidth',2)
hold on,plot(f,m,'-','Color',Color(:,2),'LineWidth',2)

hold on,plot(fCALS10k,psdCALS10k,'--','Color',Color(:,3),'LineWidth',1)
hold on,plot(fCALS10k(inds),psdCALS10k(inds),'Color',Color(:,3),'LineWidth',2)


set(gca,'YScale','log')
set(gca,'XScale','log')
xlabel('Frequency (cycles/kyr)')
ylabel('Power (10^{44} A^2 m^4 kyr)')
set(gca,'FontSize',16)
set(gcf,'Color','w')
axis([0 1e2 1e-8 3e2])