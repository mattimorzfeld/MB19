function out = MyPrior(theta)

% parameter bounds
% chose wide intervals, so all information comes from data
n = length(theta);


% xbar = 5.23;    % in 10^22 A m^2
% D = 0.3403;     % in 10^44 A^2 m^4 / kyr
% g = 0.075;      % in 1/kyr
% Ts = 2.5;       % in kyr
% a = 20;         % in 1/kyr
% % combine in parameter vector
% theta = [xbar D g Ts a]';


lb = [0  0.0615  0.0205  1   5]';
ub = [10 2.1     0.7     5  40]';
 
if sum(theta>lb)==n && sum(theta<ub)==n
    out = 0;%-0.5*((theta(1)-5.56)/0.24)^2;
else
    out = -inf;
end