function theta_init = MakeInitialEnsemble(s,theta)
%% generates initial ensemble for Hammer runs
%% uses Gaussian with variance s^2, centered at theta
n = length(theta);
Ne = 2*n;
theta_init = zeros(n,Ne);
theta_init(:,1) = theta;
s = s*sqrt(theta);
counter = 2;
go = 1;
while go == 1
    tmp = theta + s.*randn(n,1);
    if isinf(MyPrior(tmp))==0
        theta_init(:,counter) = tmp;
        counter = counter +1;
    end
    if counter>Ne
        go = 0;
    end
end