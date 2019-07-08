clear
close all
clc
colors

%% Find noise model for low-frequency spectral data


% %% Parameters
% % -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% % -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% xbar = 5.23;    % in 10^22 A m^2
% D = 0.3403;     % in 10^44 A^2 m^4 / kyr
% g = 0.075;      % in 1/kyr
% Ts = 1.5;       % in kyr
% a = 20;         % in 1/kyr
% xclip = 6.85;
% % combine in parameter vector
% theta = [xbar D g Ts a]';
% % -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% % -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% 
% load mySint2000psd.mat
% load myPADM2Mpsd.mat
% 
% T = 2; % 2 Myr runs
% Nexps = 10000; 
% psdModel = zeros(1001,Nexps);
% for kk = 1:Nexps
%     fprintf('Running exp. %g/ %g\n',kk,Nexps)
%     [x,xs,~] =  RunMyrModel(T*1e3,theta,0);
%     [psdX, f] = pspectrum(abs(x), 1);
%     psdX = interp1(f,psdX,fSint);
%     psdModel(:,kk) = psdX;
% end
% 
% figure
% loglog(f,psdModel(:,1:500),'Color',[Color(:,1);.1])
% hold on, loglog(fSint,psdSint,'Color',Color(:,4),'LineWidth',2)
% hold on, loglog(fSint,psdPADM2M,'Color',Color(:,5),'LineWidth',2)
% set(gcf,'Color','w')
% set(gca,'FontSize',16)
% box off
% 
% % Build noise model
% P = cov(psdModel');
% L = chol(P)';
% m = mean([psdSint psdPADM2M],2);
% 
% save('LF_NoiseModel.mat','L','P','f','m')


%% Illustrate noise model
load LF_NoiseModel.mat
load mySint2000psd.mat
load myPADM2Mpsd.mat
Nexps = 1000;
X = zeros(length(m),Nexps);
for kk = 1:Nexps
    fprintf('sample %g/%g\n',kk,Nexps)
    go = 1;
    while go == 1
        tmp = m+L*randn(length(m),1); 
        if sum(tmp>0)==length(m)
            X(:,kk) = tmp;
            go = 0;
        end
    end
end

%%
close all
figure
loglog(f,X,'Color',[Color(:,1);.1])
hold on, loglog(fSint,m,'Color',Color(:,2),'LineWidth',2)
hold on, loglog(fSint,psdSint,'Color',Color(:,4),'LineWidth',2)
hold on, loglog(fSint,psdPADM2M,'Color',Color(:,5),'LineWidth',2)
set(gcf,'Color','w')
set(gca,'FontSize',16)
box off
axis([2e-4 7e-1 1e-4 5e2])
xlabel('Frequency (cycles/kyr)')
ylabel('Power (10^{44} A^2 m^4 kyr)')





