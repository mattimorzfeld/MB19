function  [X,Xs,t] = RunMyrModel(T,theta,type)
% theta = [xbar D g Ts a]';
xbar = theta(1);
D = theta(2);
Ts = theta(4);

dt = 1; % kyr
t = (0:dt:T-dt)*1e-3; % in Myr
Steps = T/dt;
X = zeros(Steps,1);
X(1) = 5.8;
x = X(1);
for kk=2:Steps
    k1 = v(x,theta,type);
    k2 = v(x+dt/2*k1,theta,type);
    k3 = v(x+dt/2*k2,theta,type);
    k4 = v(x+dt*k3,theta,type);
    x = x+dt/6*(k1+2*k2+2*k3+k4)+sqrt(2*dt*D)*randn;
    X(kk) = x;
end
Xs = smooth(X,2*Ts);
