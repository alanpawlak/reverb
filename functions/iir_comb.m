function [yfile, bcoeff, acoeff] = iir_comb(x, g, sample_delay)
%IRR_COMB designed for testing not used by the reverb.m
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
if g >= 0.85
    g = 0.8;
    warning('One of the comb filters had gain higher then 0.85. Reverb time may be inaccurate')
end

bcoeff = [1];
acoeff = [1 zeros(1,sample_delay-1) g];

yfile = filter(bcoeff, acoeff, x);

end

