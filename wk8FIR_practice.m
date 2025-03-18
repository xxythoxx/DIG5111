cutoff = 300; %cutoff freq. in HZ
fs = 4000; %sampling freq.
M = 61; %number of steps/points
%n = -floor(M/2):floor(M/2); % time indices (from -30 to 30)
t = n /fs; %time 

norm_ratio = cutoff / (fs/2);

b = norm_ratio*sinc(norm_ratio*(-30:30));

plot(b)
t = 0:1/fs:1-(1/Fs);
f1 = 150; % Frequency 1 (150 Hz)
f2 = 800; % Frequency 2 (800 Hz)
signal = sin(2*pi*f1*t) + sin(2*pi*f2*t);

filtered_signal = conv(signal,b);
plot (filtered_signal)