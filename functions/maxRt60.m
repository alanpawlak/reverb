function rt60 = maxRt60(delay,gain, fs)
%maxRt60 Calculate maximum rt60
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
%   This function will check if gains for combs are good, according to 
%   Schroeder, M. R. (1962). Natural Sounding Artificial Reverberation.
%`  It will calculate what is the maximum rt60 that can be achieved for
%   given comb delays and gains.

for k = 1:length(delay)
    if gain(k) >= 0.85
        gain(k) = 0.84; 
    end
    rt60(k) = (3*delay(k)/fs)/-log10(gain(k));
end
rt60 = min(rt60);

