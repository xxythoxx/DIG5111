function sig = DaveSineWave(A, freq, Fs, dur, theta)
Ts = 1/Fs; %sample interval
t = 0:Ts;dur; %sample points array

theta_radians = theta/180*pi; % phase offset in radians
sig = A * sin(2* pi * freq .*t + theta_radians); % generate sine wave
plot(t,sig) % plot wave
xlabel('time in seconds')
ylabel('amplitude');
grid on 


end