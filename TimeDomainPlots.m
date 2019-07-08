%% Time domain plots
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
load myPADM2M.mat
load mySint2000.mat
% figure

[~,tmps,t] = RunMyrModel(2e3,mean(X,2),modelTypeForSimulation);
% % plot(t-2,abs(tmp),'Color',Color(:,1),'LineWidth',2)
% % hold on,plot(t-2,abs(tmps),'Color',Color(:,2),'LineWidth',2)
% hold on,plot(tSint2000,abs(dipoleSint2000),'Color',Color(:,5),'LineWidth',2)
% hold on,plot(tPADM2M,abs(dipolePADM2M),'Color',Color(:,4),'LineWidth',2)
% hold on,plot(t-2,abs(tmps),'Color',Color(:,2),'LineWidth',2)
% 
% 
% set(gcf,'Color','w')
% set(gca,'FontSize',20)
% box off
% xlabel('Time (Myr)')
% ylabel('VADM (10^{22} A m^2)')



%
figure
% [tmp,tmps,t] = RunMyrModel(2e3,X(:,randi(length(X))),modelTypeForSimulation);
% plot(t-2,tmp,'Color',Color(:,1),'LineWidth',2)
hold on,plot(tSint2000,dipoleSint2000,'Color',Color(:,5),'LineWidth',2)
hold on,plot(tPADM2M,dipolePADM2M,'Color',Color(:,4),'LineWidth',2)
hold on,plot(t-2,tmps,'Color',Color(:,2),'LineWidth',2)

set(gcf,'Color','w')
set(gca,'FontSize',16)
box off
xlabel('Time (Myr)')
ylabel('VADM (10^{22} A m^2)')
axis([-2 0 -12 12])

%
%% close all
[x,xcn,~,t] = RunCALS10k2Model(mean(X,2),modelTypeForSimulation);
figure
% plot(t-.01,abs(x),'Color',Color(:,1),'LineWidth',2)
hold on, plot(t-10,abs(xcn),'Color',Color(:,1),'LineWidth',2)
load myCALS10k.mat	
hold on, plot(tCALS10k*1e3,abs(dipoleCALS10k),'Color',Color(:,3),'LineWidth',2)
set(gcf,'Color','w')
set(gca,'FontSize',16)
box off
xlabel('Time (kyr)')
ylabel('VADM (10^{22} A m^2)')
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-