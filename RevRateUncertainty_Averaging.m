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

nos = 1e2;
T  = 10; % 2 Myr run
Ts = (1:8)*10;
RevRates = zeros(length(Ts),nos);
for kk=1:length(Ts)
    for jj=1:nos
        [~,x,t] = RunMyrModel(T*1e3,theta,1);
        xs = smooth(x,Ts(kk));
        nrev = FindReversals(t,xs);
        RevRates(kk,jj) = nrev/T;
    end
end
errorbar(Ts,mean(RevRates,2),2*std(RevRates'),'o','Color',Color(:,2),'LineWidth',2)
hold on, plot(Ts,mean(RevRates,2),'.','Color',Color(:,2),'MarkerSize',30)
set(gcf,'Color','w')
set(gca,'FontSize',16)
box off
xlabel('Average time in kyr')
ylabel('Reversals/Myr')
axis([0 90 0 9])

%% compare to Kramers rule
xbar = theta(1);
D = theta(2);     % in 10^44 A^2 m^4 / kyr
g = theta(3);     % in 1/kyr
a = theta(5);     % in 1/kyr

% Reversal rate
s  = sqrt(D/g);
RevRateSave(kk) = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3;
rr = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3
hold on, plot([Ts(1) Ts(end)],[rr rr],'--','Color',Color(:,5),'LineWidth',2)
