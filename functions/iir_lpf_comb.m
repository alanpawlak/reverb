function [yfile, bcoeff, acoeff] = iir_lpf_comb(x, g, sample_delay, fc, fs)
%IRR_LPF_COMB Low-Passed Feedback Comb Filter, as discussed in the report
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
if g >= 0.85
    g = 0.8;
    warning('One of the comb filters had gain higher then 0.85. Reverb time may be inaccurate')
end

a1 = exp(-2*pi*fc/fs);

% b0LPcoeffs = 1 - a1;
% a1LPcoeffs = [1 -a1]

bcoeff = [1 -a1];
acoeff = [1 -a1 zeros(1,sample_delay-2) g*(1-a1)];

yfile = filter(bcoeff, acoeff, x);

end

