function loglikeCALS10k2 = HF_Feature(a,D,g)
%% 
load HF_NoiseModel.mat
load CALS10kpsd.mat
f = fCALS10k(inds);
S = 2*D./(g^2+4*pi^2*f.^2);
S = (S*a^2)./(a^2+4*pi^2*f.^2);
loglikeCALS10k2 = .5*norm(L\(m-S))^2;
