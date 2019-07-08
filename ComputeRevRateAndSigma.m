%% compute Reversal rate and standard deviation (With correction)
nos = 2e3;
StandDevSave = zeros(nos,1);
RevRateSave = zeros(nos,1);
for kk=1:nos
    ind = randi(length(X));
    theta = X(:,ind);

    xbar = theta(1);
    D = theta(2);     % in 10^44 A^2 m^4 / kyr
    g = theta(3);     % in 1/kyr
    Ts = theta(4);    % in kyr
    a = theta(5);     % in 1/kyr

    % Reversal rate
    s  = sqrt(D/g);
    RevRateSave(kk) = (g/2/pi)*exp(-(xbar/s)^2/6)*1e3; 
    % sigma 
    CorrectionFactor = exp((g*Ts)^2 /12) *erfc(g*Ts/2/sqrt(3));
    StandDevSave(kk)  = sqrt(D/g*CorrectionFactor);
end
fprintf('Reversal rate: %g / %g\n',mean(RevRateSave),std(RevRateSave))
fprintf('Sigma: %g / %g\n',mean(StandDevSave),std(StandDevSave))