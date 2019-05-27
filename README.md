# University Assignment (DSP) - Digital Reverb Development

The effect of the room acoustics on the sound can be recreated by modelling the room impulse response using digital signal processing. Basing on the content taught in the DSP module (at University of Huddersfield), various books on digital signal processing and findings from the work done by Schroeder (1962) and Moorer (1979), an artificial reverb system has been constructed in MATLAB.

## Background

Schroeder (1962) in his publication on natural-sounding artificial reverberation, motivated by the two main problems of the reverberators available back then – their frequency response and insufficient echo density, suggested two approaches to artificial reverberation. One of them was featuring all-pass filters, which eliminated flutter and coloration.  Second approach involved a combination of four parallel comb filters and two all-pass filters connected in series. Moorer (1979) has continued research on artificial reverberation and made some  improvements to Schroeder comb and all-pass filter reverberation network. The idea behind artificial reverberation is to create a decaying response using comb filters emulating room modes and diffuse it using all-pass filters (Fenton, 2018b). The reverberator in this project employs findings presented by both authors.

### Signal flow

The overall signal flow follows the design proposed by Moorer (1979).

* Tapped delay line - to simulate early reflections.
* Six parallel comb filters, with single pole IIR, low-pass filter implemented in the feedback loop.
* Two all-pass filters conected in series.
* Delay line to shift the late portion, so the last early reflection corresponds in time with the first element of the reverberant tail.

### Specification

The main project file is reverb.m MATLAB function. All the additional, functions necessary for the processing are in functions directory. Main project file can be executed simply by calling:

```
[y,fs] = reverb;
```

This will execute function using the default settings which are following:
*	RT60: 2 seconds
*	Early reflections: 
	* Time of arrival: 4.3 ms, 21.5 ms, 22.5 ms, 26.8 ms, 27 ms, 29.8 ms, 45.8 ms, 48.5 ms, 57.2 ms, 58.7 ms, 59.5 ms, 61.2 ms, 70.7 ms, 70.8 ms, 72.6 ms, 74.1 ms, 75.3 ms, 79.7 ms.
	* Gain: 0.841, 0.504, 0.491, 0.379, 0.380, 0.346, 0.289, 0.272, 0.192, 0.193, 0.217, 0.181, 0.180, 0.181, 0.176, 0.142, 0.167, 0.134.
*	Initial comb filter delay: 50 ms.
*	Cutoff frequency of the low-pass filter implemented in comb filter feedback: 2600 Hz.
*	Dry/Wet: 100% Wet

### References 

* Moorer, J. A. (1979). About This Reverberation Business. Computer Music Journal, 3(2), 13.
* Schroeder, M. R. (1962). Natural Sounding Artificial Reverberation. Journal of the Audio Engineering Society, 10(3), 219–223.



