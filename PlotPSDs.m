%% Plot data and psd's from samples from posterior
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
load mySint2000psd.mat
load myPADM2Mpsd.mat
load CALS10kpsd.mat

% figure(12)
% loglog(fSint,psdSint,'Color',Color(:,5),'LineWidth',2)
% hold on,loglog(fPADM2M,psdPADM2M,'Color',Color(:,4),'LineWidth',2)
% hold on, loglog(fCALS10k,psdCALS10k,'-','Color',Color(:,3),'LineWidth',2)


nos = 200;
aLevel = 0.05; % transparency for plots
figure(12)
RevRate = zeros(nos,1);
StandDev = zeros(nos,1);
for kk=1:nos
    sample = X(:,randi(length(X)));
    xbar = sample(1);
    D = sample(2);
    g = sample(3);
    Ts = sample(4);
    a = sample(5);
    
    PlotFeatureLF(D,g,Ts,fSint,[Color(:,1);aLevel])
    PlotFeatureHF(D,g,a,fCALS10k,[Color(:,2);aLevel])
%     drawnow
    s  = sqrt(D/g);
    StandDev(kk) = s;
    if modelTypeForSimulation == 1
        rr = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3;
    elseif modelTypeForSimulation == 2
        rr = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3;
    elseif modelTypeForSimulation == 3
        rr = (g/2/pi)*exp(-(xbar/s)^2*(13/64))*1e3;  
    else
        error('Unknown model for reversal rate calculations')
    end
    RevRate(kk) = rr; % in Myr 
end

hold on,loglog(fSint,psdSint,'Color',Color(:,5),'LineWidth',2)
hold on,loglog(fPADM2M,psdPADM2M,'Color',Color(:,4),'LineWidth',2)
hold on, loglog(fCALS10k,psdCALS10k,'-','Color',Color(:,3),'LineWidth',2)

axis([5e-4 1e2 1e-8 120])
xlabel('Frequency in 1/Myr')
set(gcf,'Color','w')
set(gca,'FontSize',20)
drawnow

% figure(13)
% hist(RevRate)
% xlabel('Reversal rate in 1/Myr')
% set(gcf,'Color','w')
% box off
% set(gca,'FontSize',20)
% 
% figure(23)
% hist(StandDev)
% xlabel('Standard Deviation')
% set(gcf,'Color','w')
% box off
% set(gca,'FontSize',20)
% 
% 
% fprintf('Reversal rate = %g pm %g\n',mean(RevRate),std(RevRate))
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-