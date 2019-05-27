function [yfile, bcoeff, acoeff] = singlePoleLpf(x, fs, fc)
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
% LP filter, designed for testing not used by the reverb.m

a1 = exp(-2*pi*fc/fs);

bcoeff = 1 - a1;
acoeff = [1 -a1];

yfile = filter(bcoeff, acoeff, x);

end