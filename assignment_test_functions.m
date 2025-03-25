Fs = 44100; %specifies sampling frequency
ts = 1/Fs; % calculates sampling period FOR DFT

audioread('filename.wav'); %read in the audio file
audiowrite('filename.wav',y,Fs); %names file as Y, rewrites to specified sampling freq.

normalise (y,'range',[-1,1]);%normalises Y
spectrogram (y,window, overlap, nfft, Fs, 'yAxis'); % plots a spectrogram


plot (t,Y); %plotting waveform

filterDesigner %uses built in filter design app 
%%Y = filter(b,a,x); % y is output, x is input signal, b is array of denom. coefficients, a is array of numer. coefficients

%formatting for using spectrogram S = spectrogram(x,window,noverlap,nfft,fs) 
%e.g spectrogram(chirpsig,128,120,128,10000);
% would take file chirpsig, 128 is the window (128rectangular window which
%does have spectral leakage),3rd argument (120) is overlap (moving over 8 
%samples at a time), with the other 128 being framesize. 10000 is sample
%freq.
%% BIQUAD FILTER
Fs = 44100; %specify sampling frequency
fc = 2000; %specify cutoff frequency
[b, a] = butter(2, fc/(Fs/2)); %2nd order butterworth

x = randn(1,1000); %Generates a random signal
Y = filter(b,a,x); % y is output, x is input signal, b is array of denom. coefficients, a is array of numer. coefficients
plot(y);




