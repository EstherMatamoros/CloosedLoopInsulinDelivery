function [dzdt]=glysimulink(x)
k=0.0108;
T1 = 6;

% A   = x(1);
% Ath = x(2);
b   = x(1)>0;
z   = x(2);
%b=  A-Ath;
if b < 0
    dzdt =0;
elseif b>0 
    dzdt = k;
elseif b==0
    dzdt= - z/T1;  
end 
end