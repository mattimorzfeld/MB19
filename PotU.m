function out = PotU(x,g,xbar)
if x>0
    out = g*(x^3/3-x^2*xbar/2)/xbar;
else
    out = -g*(x^3/3+x^2*xbar/2)/xbar;
end