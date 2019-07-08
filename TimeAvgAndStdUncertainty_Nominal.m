%%
clear
close all
clc
colors

theta =[5.23;    % in 10^22 A m^2
        0.3403;     % in 10^44 A^2 m^4 / kyr
        0.075;      % in 1/kyr
        2.5;       % in kyr
        20];

nos = 1e3;
T  = 2;%[1:30]; % 2 Myr run
Avg = zeros(length(T),nos);
StanDev = zeros(length(T),nos);
for kk=1:length(T)
    for jj=1:nos
        [~,xs,t] = RunMyrModel(T(kk)*1e3,theta,1);
        Avg(kk,jj) = mean(abs(xs));
        StanDev(kk,jj) = std(abs(xs));
    end
end
errorbar(T,mean(Avg,2),2*std(Avg'),'o','Color',Color(:,2),'LineWidth',2)
hold on, plot(T,mean(Avg,2),'.','Color',Color(:,2),'MarkerSize',30)
set(gcf,'Color','w')
set(gca,'FontSize',16)
box off
xlabel('Length of reversal record in Myr')
ylabel('Time average')




figure
errorbar(T,mean(StanDev,2),2*std(StanDev'),'o','Color',Color(:,2),'LineWidth',2)
hold on, plot(T,mean(StanDev,2),'.','Color',Color(:,2),'MarkerSize',30)
set(gcf,'Color','w')
set(gca,'FontSize',16)
box off
xlabel('Length of reversal record in Myr')
ylabel('Standard deviation')



%% compare to approximation
xbar = theta(1);
D = theta(2);     % in 10^44 A^2 m^4 / kyr
g = theta(3);     % in 1/kyr
Ts = theta(4);    % in kyr
a = theta(5);     % in 1/kyr
s  = sqrt(D/g);
figure(1)
hold on, plot([T(1) T(end)],[xbar xbar],'--','Color',Color(:,5),'LineWidth',2)
figure(2)
hold on, plot([T(1) T(end)],[s s],'--','Color',Color(:,5),'LineWidth',2)