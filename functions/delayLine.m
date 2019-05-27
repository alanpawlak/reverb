function [yfile, bcoeff, acoeff] = delayLine(x, sample_delay)
%DELAYLINE Simple delay line, used to delay late portion
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
bcoeff=[zeros(1,sample_delay) 1];
acoeff=[1];

yfile = filter(bcoeff, acoeff, x);
end