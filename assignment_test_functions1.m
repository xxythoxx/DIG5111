Fs = 44100; %specifies sampling frequency
ts = 1/Fs; % calculates sampling period FOR DFT

audioread('filename.wav'); %read in the audio file
audiowrite('filename.wav',y,Fs); %names file as Y, rewrites to specified sampling freq.

normalise (y,'range',[-1,1]);%normalises Y
spectrogram (y,window, overlap, nfft, Fs, 'yAxis'); % plots a spectrogram


plot (t,Y); %plotting waveform

filterDesigner %uses built in filter design app 
%%Y = filter(b,a,x); % y is output, x is input signal, b is array of denom. coefficients, a is array of numer. coefficients

%% BIQUAD FILTER
Fs = 44100; %specify sampling frequency
fc = 2000; %specify cutoff frequency
[b, a] = butter(2, fc/(Fs/2)); %2nd order butterworth

x = randn(1,1000); %Generates a random signal
Y = filter(b,a,x); % y is output, x is input signal, b is array of denom. coefficients, a is array of numer. coefficients
plot(y);




