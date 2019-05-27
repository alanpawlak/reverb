function [y, b_coeffs, a_coeffs] = tdl(x, ErDelay, ErGain)
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
%   Tapped Delay Line implemented as an FIR filter

%   Check if the ErDelay and ErGain arrays have the same number of elements
if length(ErDelay) ~= length(ErGain)
    error('Delay and Gain arrays must have same number of elements')
else
    %Create number of taps
    taps = length(ErDelay);
end

%Order of the filter is equal to time of arrival of the last reflection

b_coeffs = [1 zeros(1,max(ErDelay))]; % Memory allocation for ErDelay
a_coeffs = 1;

% Loop through taps and set the b coefficient for every reflection
for n = 1:taps
    b_coeffs(ErDelay(n)+1) = ErGain(n);
end

% Filter signal
y = filter(b_coeffs,a_coeffs, x);