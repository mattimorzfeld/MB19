%%
clear
close all
clc
colors


%% What results do you want to look at?
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
nos = 1e6;
WhichSetUp = 'e';

if WhichSetUp == 'a'
    %% (a) All data, tight constraints
    w = [1 1 1 1];
    rrate = 4.23;
    rrate_std = 0.05;
    xbar_std = .048;
    sig_std = .036;
elseif WhichSetUp == 'b'
    %% (b) No CALS10k.2
    w = [1 1 0 1];
    rrate = 4.23;
    rrate_std = 0.05;
    xbar_std = .048;
    sig_std = .036;
    
elseif WhichSetUp == 'c'
    %% (c) All data, lose constraints
    w = [1 1 1 1];
    rrate = 4.23;
    rrate_std = 0.5;
    xbar_std = .48;
    sig_std = .36;
    
elseif WhichSetUp == 'd'
    %% (d) Only spectral data
    w = [1 0 1 0];
    rrate = 4.23; % meaningless
    rrate_std = 0.5; % meaningless
    xbar_std = .48; % meaningless
    sig_std = .36; % meaningless
    
elseif WhichSetUp == 'e'
    %% (e) Only rev.rate, std and time average data, tight constraints
    w = [0 1 0 1];
    rrate = 4.23;
    rrate_std = .05;
    xbar_std = .048;
    sig_std = .036;
elseif WhichSetUp == 'f'
    %% (g) Only Sint and PADM2M
    w = [1 0 0 0];
    rrate = 4.23; % meaningless
    rrate_std = .5; % meaningless
    xbar_std = .48;% meaningless
    sig_std = .36; % meaningless    
elseif WhichSetUp == 'g'
    %% (f) Only CALS10k.2
    w = [0 0 1 0];
    rrate = 4.23; % meaningless
    rrate_std = .5; % meaningless
    xbar_std = .48;% meaningless
    sig_std = .36; % meaningless
end

modelTypeForEstimation = 1;
modelTypeForSimulation = 1;  % can be 1 or 3 if modelTypeForEstimation = 1
                             % must be 2 if modelTypeForEstimation = 2
LoadAndRemoveBurnIn  
disp(' ')

T  = [10]; % 2 Myr run

%% posterior parameter uncertainty
nos = 1e3;
RR = zeros(nos,1);
for kk=1:nos
    theta = X(:,randi(length(X),1));
    xbar = theta(1);
    D = theta(2);     % in 10^44 A^2 m^4 / kyr
    g = theta(3);     % in 1/kyr
    Ts = theta(4);    % in kyr
    a = theta(5);     % in 1/kyr
    
    % Reversal rate
    s  = sqrt(D/g);
    RevRateSave(kk) = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3;
    RR(kk) = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3;
end
hold on, plot([T(1) T(end)],[RR RR],'-','Color',[[128; 128; 128]/255; 0.1],'LineWidth',2)


%% uncertainty due to shortness of record
theta =mean(X,2);
nos = 1e5;
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
ylabel('Standard deviation in Reversals/Myr')

fprintf('Reversal rate: %g \n',mean(RevRates,2))
fprintf('Standard deviation: %g\n',std(RevRates'))


%% compare to Kramers rule
xbar = theta(1);
D = theta(2);     % in 10^44 A^2 m^4 / kyr
g = theta(3);     % in 1/kyr
Ts = theta(4);    % in kyr
a = theta(5);     % in 1/kyr
s  = sqrt(D/g);
RevRateSave(kk) = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3;
rr = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3;
figure(1),
hold on, plot([T(1) T(end)],[rr rr],'-','Color',Color(:,5),'LineWidth',2)

fprintf('Kramers rule: %g \n',rr)



