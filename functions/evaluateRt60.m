function [dels,gain] = evaluateRt60(rt60, combDelay, fs)
%EVALUATERT60 Summary of this function goes here
% This function will generate delays and gains based on initial comb delay
% and rt60. It will also evaluate is desired rt60 is possible to achieve
% with given values.
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
dels = givePrime(round(linspace(combDelay, combDelay*1.5,6)));
gain = gans(dels,fs,rt60);

% Calculate the maximum possible rt60 that the system is able to achieve
% with combDelay value
Rt60_2 = round(maxRt60(dels, gain, fs),2);

if rt60 > Rt60_2
    rt60 = Rt60_2;
    warning(['The RT60 will be attenuated to ' num2str(Rt60_2) 's due to comb delay value. Increase intitial comb delay to achieve higher reverb times.'])
    dels = givePrime(round(linspace(combDelay, combDelay*1.5,6)));
    gain = gans(dels,fs,rt60);
end
end

