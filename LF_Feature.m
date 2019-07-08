function loglikeLowFreq = LF_Feature(D,g,Ts)

load LF_NoiseModel.mat
S1 = 2*D./(g^2+4*pi^2*f.^2);
fTF = exp(-4*pi^2*f.^2*Ts^2/24);
S2 = S1.*(fTF.^2);
ind = 100;
loglikeLowFreq = .5*norm(L\([S1(1:ind);S2(ind+1:end)]-m))^2;



    