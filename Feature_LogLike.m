function out = Feature_LogLike(theta,w,rrate,rrate_std,xbar_std,sig_std,modelType)
xbar = theta(1);
D = theta(2);     % in 10^44 A^2 m^4 / kyr
g = theta(3);     % in 1/kyr
Ts = theta(4);    % in kyr
a = theta(5);     % in 1/kyr

out = w(1)* LF_Feature(D,g,Ts)...
        + w(2)* RevRate_Feature(xbar,D,g,rrate,rrate_std,modelType) ...
            + w(3)* HF_Feature(a,D,g) ...
                +w(4)* MeanAndStandDev_Feature(xbar,D,g,Ts,xbar_std,sig_std);
