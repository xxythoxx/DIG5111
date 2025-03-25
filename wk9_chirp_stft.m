Fs=10000; %10kHz sample freq
A=0.8;
Ts=1/Fs; %sample intervals
dur=1.5; %length in secs
t=0:Ts:dur; 
Theta=2*pi*(100+200*t+500*t.*t); %as time changes, frequency changes
%when t = 0, its going to tell what start frequency is (so the 200 is
%200Hz)
%when t is = to end duration, itll tell us the end of chirp signal
%(1000*1.5)+200
%for example, sweeping from 20-20kHz over 3 seconds...
%20000/20 = A VALUE
%3/2
% theta = 2*pi*(100+________________________

framesize = 512;
overlap = 1024;

chirpsig=A*sin(Theta); %makes the chirp signal
audiowrite('mychirp1.wav',chirpsig,Fs); %writes chirp to an audio file,
%taking calculations from chirpsig and applying them with the sampling
%frequency


%formatting for using spectrogram S = spectrogram(x,window,noverlap,nfft,fs) 
%e.g spectrogram(chirpsig,128,120,128,10000); would take file chirpsig, 

spectrogram(chirpsig,hann(framesize),256, framesize, Fs, 'yAxis');