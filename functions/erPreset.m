function [ErDelay,ErGain] = erPreset(presetnum, ErDelay, ErGain)
%ERPRESET Will error check ER data and store presets
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
%   Error check section
if ~exist('presetnum') presetnum = 4; warning('No ER preset data. ER Pattern changed to random'); end
if nargin > 2 presetnum = 0; end
if nargin > 2 && min(ErDelay) < 0 presetnum = 4; warning('ER delay cant be lower than 0ms. ER Pattern changed to random'); end
if nargin < 2 && presetnum == 0 presetnum = 4; warning('No input ER Data. ER Pattern changed to random'); end

switch presetnum
    case 0
        % Use input ER Data
        ErDelay = ErDelay;
        ErGain = ErGain;
    case 1
        % Living room ? 
        ErDelay = [5 9 11 16 20 24 29];
        ErGain = [0.718 0.612 0.719 0.642 0.742 0.512 0.514];
    case 2
        % These are for "reasonable-sounding seven tap FIR" / Moorer, J. A.
        % (1979). About This Reverberation Business. /
        ErDelay = [19.9 35.4 38.9 41.4 69.9 79.6];
        ErGain = [1.02 0.818 0.635 0.719 0.267 0.242];
    case 3
        % These are from Boston Symphony Hall / Moorer, J. A. (1979). About
        % This Reverberation Business.  /
        ErDelay = [4.3 21.5 22.5 26.8 27 29.8 45.8 48.5 57.2 58.7 59.5 61.2 70.7 70.8 72.6 74.1 75.3 79.7];
        ErGain = [0.841 0.504 0.491 0.379 0.380 0.346 0.289 0.272 0.192 0.193 0.217 0.181 0.180 0.181 0.176 0.142 0.167 0.134];
    otherwise
        % Create random ER
        ErDelay = (((800-50).*rand(10,1) + 50)/1000);
        ErGain = ((80-40).*rand(10,1) + 40)/100;
end
end

