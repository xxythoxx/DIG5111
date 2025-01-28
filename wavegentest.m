Fs = 1000; %sample rate in Hz
Ts = 1/Fs; %sample interval
dur = 3; %duration in seconds
t = 0:Ts:dur; %sample points array
A = 1; %peak amplitude
freq = 1; % frequency in Hz
deg1 = 90; % degrees function
theta = deg1; %Phase offset in degrees

sig = A + sin ( 2* pi * freq .*t + theta); %generate sine wave
% the dot does element wise operation
plot (t,sig) %plot wave 
xlabel('Time in seconds')
ylabel('Amplitude')
grid on