function [y,bcoeff,acoeff] = allpass(x,sample_delay,g)
%ALLPASS All- pass filer transfer function - discussed in the report
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
bcoeff=[g zeros(1,sample_delay-1) 1];
acoeff=[1 zeros(1,sample_delay-1) g];

y = filter(bcoeff,acoeff,x);
end

