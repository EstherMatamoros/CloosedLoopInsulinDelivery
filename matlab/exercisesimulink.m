function [dydt]=exercisesimulink(x)
%tau=-1.521*u +87.471;
u3=x(1);
y=x(2);
%pvo=y
dydt= (-0.8*y + 0.8*u3);    
end 

