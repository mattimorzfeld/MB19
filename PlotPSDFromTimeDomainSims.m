
%%  Fequency domain plots from short model runs
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
nos = 1e2;
T  = 2*1e3; % 2 Myr run
Spectra_Myr = zeros(length(fSint),nos);
Spectra_Myr_smoothed = zeros(length(fSint),nos);
Spectra_kyr_cn = zeros(length(fCALS10k),nos);
Spectra_kyr_wn = zeros(length(fCALS10k),nos);

alevel=1;%0.05;
figure



for kk=1:nos
    fprintf('Spectra simulation %g / %g\r',kk,nos)
    ind = randi(length(X));
    [x,xs,~] = RunMyrModel(T,X(:,ind),modelTypeForSimulation);
    [psdX, ~] = pspectrum(abs(x), 1);
    [psdXs, fMyr] = pspectrum(abs(xs), 1);
    Spectra_Myr(:,kk) = psdX;
    Spectra_Myr_smoothed(:,kk) = psdXs;
    
    [xwn,xcn,~,~] = RunCALS10k2Model(X(:,ind),modelTypeForSimulation);
    [psdxcn, fkyr] = pspectrum(abs(xcn), 1000);
    Spectra_kyr_cn(:,kk) = psdxcn(1:length(fCALS10k));
    [psdxwn, fkyr] = pspectrum(abs(xwn), 1000);
    Spectra_kyr_wn(:,kk) = psdxwn(1:length(fCALS10k));
end

% load LFErrorCloud.mat
% load HFErrorCloud.mat
load HF_NoiseModel.mat
load LF_NoiseModel.mat
f_LF_ErrorCloud = f;
f_HF_ErrorCloud = fCALS10k(inds);
load LF_Noise_Spectra.mat
load HF_Noise_Spectra.mat
% myerrorCloud(MX2M,2*stdX2M,f_LF_ErrorCloud)
% myerrorCloud(MX10k,2*stdX10k,f_HF_ErrorCloud)
hold on, plot(f_LF_ErrorCloud,X2M(:,1:5000),'Color',[128 128 128]/255)
hold on, plot(f_HF_ErrorCloud,X10k(:,1:5000),'Color',[128 128 128]/255)


% hold on, plot(fMyr,Spectra_Myr,'Color',[Color(:,2);alevel])
CutOff = 280;
hold on, plot(fMyr(1:end-CutOff),Spectra_Myr_smoothed(1:end-CutOff,:),'Color',[Color(:,2);alevel])% alevel
hold on, plot(fkyr(inds),Spectra_kyr_cn(inds,:),'Color',[Color(:,1);alevel])
% hold on, plot(fkyr(1:length(fCALS10k)),Spectra_kyr_wn,'Color',[Color(:,6);alevel])

set(gca,'YScale','Log')
set(gca,'XScale','Log')
drawnow

%% PADM2M, Sint2000, CALS10k
load mySint2000psd.mat
load myPADM2Mpsd.mat
load CALS10kpsd.mat

hold on, plot(fSint,psdSint,'Color',Color(:,5),'LineWidth',2)
hold on,plot(fPADM2M,psdPADM2M,'Color',Color(:,4),'LineWidth',2)
hold on, plot(fCALS10k,psdCALS10k,'--','Color',Color(:,3),'LineWidth',2)
hold on, plot(fCALS10k(inds),psdCALS10k(inds),'-','Color',Color(:,3),'LineWidth',2)


set(gca,'YScale','log')
set(gca,'XScale','log')
set(gcf,'Color','w')
set(gca,'FontSize',16)
xlabel('Frequency (cycles/kyr)')
ylabel('Power (10^{44} A^2 m^4 kyr)')

% set(gca,'YScale','log')
% set(gca,'XScale','log')
% xlabel('Frequency (cycles/kyr)')
% ylabel('Power (10^{44} A^2 m^4 kyr)')
axis([fSint(2) 1e2 1e-8 3e2])
drawnow

% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-