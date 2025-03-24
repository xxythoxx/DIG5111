Fs = ; %specifies sampling frequency
audioread('filename.wav');
audiowrite('filename.wav',y,Fs); %names file as Y, rewrites to specified sampling freq.

normalise (y,'range',[-1,1]);%normalises Y
spectrogram (y,window, overlap, nfft, Fs, 'yAxis'); % plots a spectrogram


plot (t,Y); %plotting waveform

