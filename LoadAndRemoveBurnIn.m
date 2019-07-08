%% Loda and remove burn in
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
Filename = strcat('./Results_VarCorrection/Results_Config_',num2str(w(1)),num2str(w(2)),num2str(w(3)),num2str(w(4)), ...
                    '_RevRate_',num2str(rrate),'_RevRateSTD_',num2str(rrate_std),...
                    '_xbarSTD_',num2str(xbar_std),...
                    '_sigSTD_',num2str(sig_std),...
                    '_ModelType_',num2str(modelTypeForEstimation),...
                    '_NOS_',num2str(nos),'.mat');
load(Filename)

%% Squeeze
F = [];
X = [];
for kk=1:size(Theta,2)
    Ftmp = squeeze(logp(2,kk,1:end));
    Xtmp = squeeze(Theta(:,kk,1:end)); 
    F = [F; Ftmp];
    X = [X Xtmp];
end


%% Integrated auto-correlation
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
n = size(Theta,1);
TauIntAv = zeros(n,1);
for xx=1:n
    [~,~,~,tauinttmp,~,~] = UWerr_fft(X(xx,:)',1.5,length(X),1,1,1);
    TauIntAv(xx) = tauinttmp;
end
TauIntAv = mean(TauIntAv);
fprintf('IACT from raw samples: %g\n',TauIntAv)
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-


%% Squeeze
BurnIn = min(1e5,ceil(10*TauIntAv));
fprintf('Burn-in is %g\n',BurnIn)
F = [];
X = [];
for kk=1:size(Theta,2)
    Ftmp = squeeze(logp(2,kk,BurnIn:end));
    Xtmp = squeeze(Theta(:,kk,BurnIn:end)); 
    F = [F; Ftmp];
    X = [X Xtmp];
end

%% Integrated auto-correlation
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
n = size(Theta,1);
TauIntAv = zeros(n,1);
for xx=1:n
    [~,~,~,tauinttmp,~,~] = UWerr_fft(X(xx,:)',1.5,length(X),1,1,1);
    TauIntAv(xx) = tauinttmp;
end
TauIntAv = mean(TauIntAv);
fprintf('IACT after burn-in: %g\n',TauIntAv)
%% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-


% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-
% -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o- -o-