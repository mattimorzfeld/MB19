function out = v(x,theta,type)
% theta = [xbar D g Ts a]';
xbar = theta(1);
g = theta(3);

if type == 0 % no reversals/ linear model
    out = -g*(x-xbar);

elseif type == 1 % B13
    if x>0
        out = -g*(x-xbar)*(x/xbar);
    else
        out = g*(-x-xbar)*(-x/xbar);   
    end
    
elseif type == 2 % revised B13
    out = g*x*(1-13/8*(x/xbar)^2 + 3/4*(x/xbar)^4-1/8*(x/xbar)^6);

elseif type == 3 % latest version, clipped
    % clip the value of x?
    xclip = 6.81;%6.85;
    if abs(x) > xclip
        x = xclip * x / abs(x);
    end
    % evaluate drift (extended quadratic model)
    out = -g * abs(x) * (abs(x) - xbar) / xbar;
    if (x < 0)  % use symmetry for negative x
        out = -out; 
    end
end

