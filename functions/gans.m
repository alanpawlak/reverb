function gain = gans(delay,rt60, fs)
%GANS Calculate gain for comb filters for given comb delays and desired
%rt60
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
% Using the formula from Schroeder, M. R. (1962). Natural Sounding Artificial Reverberation.
for k = 1:length(delay)
    gain(k) = 10^(-3*(delay(k)/(rt60*fs)));
end

