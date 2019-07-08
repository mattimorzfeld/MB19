function [nrev,trev,locate] = FindReversals(t,x)

% recovers the time of reversals and the index
% of the new polarity immediately after the reversal

ndata = length(x);

% find reversals
nrev = 0;
for k = 1 : ndata-1
    if (x(k) * x(k+1) < 0 )
        nrev = nrev + 1;
        trev(nrev) = 0.5 * (t(k) + t(k+1));
        locate(nrev) = k+1;
    end
end

end
        

  
      
      
  
  
  
  
  
  

