function  [X,Xcn,Y,t] = RunCALS10k2Model(theta,type)
% theta = [xbar D g Ts a]';
D = theta(2);
a = theta(5);

dt = .001;
T = 10;
Steps = round(T/dt);
t = (1:Steps)*dt; % in kyrs

X = zeros(Steps,1);
Y = zeros(Steps,1);
X(1) = 7.3839;
x = X(1);
Xcn = X;
xcn = x;
y = 0;
for kk=2:Steps
    xi = randn;
        
    % colored noise
    k1 = v(xcn,theta,type);
    k2 = v(xcn+dt/2*k1,theta,type);
    k3 = v(xcn+dt/2*k2,theta,type);
    k4 = v(xcn+dt*k3,theta,type);
    y = (1-a*dt)*y+ sqrt(2*a*dt)*xi;
    xcn = xcn+dt/6*(k1+2*k2+2*k3+k4)+sqrt(D*a)*y*dt;
    Xcn(kk) = xcn;
    Y(kk) = y;
    
    % white noise
    k1 = v(x,theta,type);
    k2 = v(x+dt/2*k1,theta,type);
    k3 = v(x+dt/2*k2,theta,type);
    k4 = v(x+dt*k3,theta,type);
    x = x+dt/6*(k1+2*k2+2*k3+k4)+sqrt(dt*2*D)*xi;
    X(kk) = x;
end
