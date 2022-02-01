function [dadt]=inteexeintensity(x)
u3=x(1);
a=x(2);
%x=A -> integrate exercise intensity
if (u3 > 0.08)
     dadt = u3;
else 
     dadt = -a/0.001;
end 
end 