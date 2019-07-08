clear
close all
clc
colors

%% Find noise model for high-frequency spectral data


%% Parameters
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
xbar = 5.23;    % in 10^22 A m^2
D = 0.3403;     % in 10^44 A^2 m^4 / kyr
g = 0.075;      % in 1/kyr
Ts = 2;       % in kyr
a = 20;         % in 1/kyr
% combine in parameter vector
theta = [xbar D g Ts a]';
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-

load CALS10kpsd.mat

%% 
Nexps = 5000; 
inds = 6:100;
psdModel = zeros(length(inds),Nexps);
for kk = 1:Nexps
    fprintf('Running exp. %g/ %g\r',kk,Nexps)
    go = 1;
    while go == 1
        [X,Xcn,~] = RunCALS10k2Model(theta,3);
        [psdX, f] = pspectrum(abs(Xcn), 1000);
        psdX = interp1(f,psdX,fCALS10k);
        
        if norm(psdX(inds(end))-psdCALS10k(inds(end)))<1e-3
            psdModel(:,kk) = psdX(inds);
            go = 0;
        end
    end
%     figure(8)
%     loglog(fCALS10k,psdX,'Color',[Color(:,1);.1])
%     hold on, loglog(fCALS10k(inds),psdModel(:,kk),'Color',[Color(:,1);.1])
%     hold on, loglog(fCALS10k,psdCALS10k,'Color',Color(:,4),'LineWidth',2)
%     set(gcf,'Color','w')
%     set(gca,'FontSize',16)
%     box off
%     drawnow
end
%%
figure
loglog(fCALS10k(inds),psdModel,'Color',[Color(:,1);.1])
hold on, loglog(fCALS10k,psdCALS10k,'Color',Color(:,4),'LineWidth',2)
set(gcf,'Color','w')
set(gca,'FontSize',16)
box off
 
%% Build noise model
P = cov(psdModel');
L = real(sqrtm(P));%chol(P)';
m = psdCALS10k(inds);

save('HF_NoiseModel.mat','L','P','inds','m')

%% Illustrate noise model
% load HF_NoiseModel.mat
% load CALS10kpsd.mat
% 
% Nexps = 1000;
% X = zeros(length(m),Nexps);
% for kk = 1:Nexps
%     fprintf('sample %g/%g\n',kk,Nexps)
%     go = 1;
% %     while go == 1
%         tmp = m+L*randn(length(m),1); 
% %         if sum(tmp>0)==length(m)
%             X(:,kk) = tmp;
%             go = 0;
% %         end
% %     end
% end
% %%
% figure
% loglog(fCALS10k(inds),X,'Color',[Color(:,1);.1])
% hold on, loglog(fCALS10k,psdCALS10k,'Color',Color(:,2),'LineWidth',2)
% hold on,loglog(fCALS10k(inds),m,'Color',Color(:,4),'LineWidth',2)
% set(gcf,'Color','w')
% set(gca,'FontSize',16)
% box off


