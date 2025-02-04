%week 2 lab 


filename = 'piano_middle_C.wav'; 
%reading in the piano audio file
[sig, Fs] = audioread (filename);
%Sig stores raw audio data in column;
%Fs sampling frequency

samples = [1,2*Fs];
clear y Fs
[y,Fs] = audioread (filename, 'native'); %reading audiodata, displaying size in cmd window
whos y %whos returns the number of bytes each variable occupies in the workspace

%import data for 0-0.5s and 0.5-1s into sig1 and sig2
sig1 = audioread(filename,[1,22050]);%amount of samples from 0-0.5s
sig2 = audioread(filename,[22051,44100]);%amount of samples from 0.5-1s (removing the last plotted sample in sig1)







Duration = length(sig)/Fs; %length of file
disp(Duration); %displays duration
Ts = 1/Fs; %sample interval = 1/sample freq.
Time = 0:Ts:Duration-Ts; %length of audio in time as an array,- Ts as it starts at 1, 
%assigns time to each sample value in the array
plot (Time,sig); %plots wave onto graph
ylabel("Amplitude"); %label y axis
xlabel('Time (sec)'); %label x axis


%concatenate into stereo
left_channel = audioread('piano_middle_C.wav');%taking desired audio
right_channel = audioread('piano_middle_C.wav');

Stereo_piano_middle_C = [left_channel,right_channel];%adding them together,
%as seen by stereo workspace array size
stereo_filename = "Stereo_piano_middle_C.wav" %naming the new destination file
audiowrite(stereo_filename,Stereo_piano_middle_C,Fs) %creating the audio file


%example of linear normalisation
%a = int16(-2^15:2^15-1);
%b = double(a)/max(abs(double(a)));
%disp(b)

