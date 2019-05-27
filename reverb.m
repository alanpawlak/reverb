function [y, fs] = reverb(x, fs, lpfc, rt60, iniCombDelay, erprst ,wet)
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
%   Use "[y,fs] = reverb;" to run with default settings
%   guitar2.wav is needed in the main dir for deafult settings to work!!!  
%
%   tic; [y,fs] = reverb; toc;
%   Elapsed time is 6.103851 seconds.   
%
%   x - input
%
%   fs - input fs
%
%   lpfc - cutoff of the LP filter implemented in comb filter network
%
%   rt60 - desired rt60 [s]
%
%   iniCombDelay - delay value for the first comb filter [ms] - 30ms
%   suggested by Schroeder, 50ms suggested by Moorer. The higher value, the
%   higher reverberation time can be achieved
%
%   erprst - set ER pattern  preset 1, 2, 3.
%
%   wet - dry/wet mix. wet = 100, Wet = 100%
%
%   y - output, processed signal
%   fs - output fs
%
%
%% Default input arguments
if nargin < 7 wet = 100; end
if nargin < 6 erprst = 3; end
if nargin < 5 iniCombDelay = 50; end
if nargin < 4 rt60 = 2; end
if nargin < 3 lpfc = 2600; end
if nargin < 2 [x, fs] = audioread('guitar2.wav'); end

% This allows MATLAB to use functions from 'functions' direcotry
addpath('functions')

%% ER Network

% Load ER Preset:

% erprst = 0 - custom ER data ( erPreset(0, ErDelayArray, ErGainArray) )
% erprst = 1 -  Living room
% erprst = 2 - "reasonable-sounding seven tap FIR" -  Moorer, J. A. (1979). About This Reverberation Business.
% erprst = 3 - Boston Symphony Hall - Moorer, J. A. (1979). About This Reverberation Business.
% erprst = other - randomised ER pattern

[ErDelay,ErGain] = erPreset(erprst);

% Convert ErDelay values to samples
ErDelay = ErDelay./1000.*fs;

% DAFX Book - suggested rounding ER delays to Prime numbers
ErDelay = givePrime(ErDelay);

% Delay value for the delay line, shifting late reverberation tail
lateDelay =  max(ErDelay)+1;

[tdl_out, tdl_b, tdl_a] = tdl(x, ErDelay, ErGain);


%% Late Network

% Part one - 6 IIR - Comb Filters with Low Pass Filtered Gains

% Calculate a comb delay value, which will be spread between combs in 1:1.5
% ratio
combDelay = iniCombDelay/1000*fs;

% Calculate delay values and gains for combs and evaluate if desired rt60
% is possible for given iniCombDelay
[dels,gain] = evaluateRt60(rt60, combDelay, fs);

[comb1, cB1, cA1] = iir_lpf_comb(tdl_out, gain(1), dels(1), lpfc, fs);
[comb2, cB2, cA2] = iir_lpf_comb(tdl_out, gain(2), dels(2), lpfc, fs);
[comb3, cB3, cA3] = iir_lpf_comb(tdl_out, gain(3), dels(3), lpfc, fs);
[comb4, cB4, cA4] = iir_lpf_comb(tdl_out, gain(4), dels(4), lpfc, fs);
[comb5, cB5, cA5] = iir_lpf_comb(tdl_out, gain(5), dels(5), lpfc, fs);
[comb6, cB6, cA6] = iir_lpf_comb(tdl_out, gain(6), dels(6), lpfc, fs);

%Scale output from comb filters
%This may be unecessary when the comb filters have delayed bcoeff
%Depends on the design of the comb filter network - report, chapter 2
allpassin = (comb1+comb2+comb3+comb4+comb5+comb6)/6;

% Part two - 2 All Pass Filters

allpass_gain = 0.7;
allpass_delay = 5; % ms

ap1_sample_delay = round(allpass_delay/1000*fs);
ap2_sample_delay = round(ap1_sample_delay/3);

[y,apB1,apA1] = allpass(allpassin, ap1_sample_delay, allpass_gain);
[y,apB2,apA2] = allpass(y, ap2_sample_delay, allpass_gain);

% Delay line that shifts the late reverberant tail
[y, DLb1, DLa1] = delayLine(y,lateDelay);

%% Output stage

% Add early reflections
y = y + tdl_out;

% Normalise the wet signal and scale so its magnitude is same as an input
y = (y/max(y))*max(x);

% Dry/Wet mix section
g1 = (100-wet)/100;
g2 = wet/100;

% Output
y = x*g1 + y * g2;
end