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

nos = 1e5;
T  = [10]; % 2 Myr run
RevRates = zeros(length(T),nos);
for kk=1:length(T)
    for jj=1:nos
        [~,xs,t] = RunMyrModel(T(kk)*1e3,theta,1);
        xs = smooth(xs,30);
        nrev = FindReversals(t,xs);
        RevRates(kk,jj) = nrev/T(kk);
    end
end
errorbar(T,mean(RevRates,2),2*std(RevRates'),'o','Color',Color(:,2),'LineWidth',2)
hold on, plot(T,mean(RevRates,2),'.','Color',Color(:,2),'MarkerSize',30)
set(gcf,'Color','w')
set(gca,'FontSize',16)
box off
xlabel('Length of reversal record in Myr')
ylabel('Reversals/Myr')

figure
hold on, plot(T,std(RevRates'),'.','Color',Color(:,2),'MarkerSize',30)
set(gcf,'Color','w')
set(gca,'FontSize',16)
box off
xlabel('Length of reversal record in Myr')
ylabel('Stand deviation in Reversals/Myr')


fprintf('Reversal rate: %g \n',mean(RevRates,2))
fprintf('Standard deviation: %g\n',std(RevRates'))


%% compare to Kramers rule
xbar = theta(1);
D = theta(2);     % in 10^44 A^2 m^4 / kyr
g = theta(3);     % in 1/kyr
Ts = theta(4);    % in kyr
a = theta(5);     % in 1/kyr

% Reversal rate
s  = sqrt(D/g);
RevRateSave(kk) = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3;
rr = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3;
fprintf('Kramers rule: %g \n',rr)

figure(1)
hold on, plot([T(1) T(end)],[rr rr],'--','Color',Color(:,5),'LineWidth',2)
