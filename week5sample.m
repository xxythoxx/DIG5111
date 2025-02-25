ir = zeros(1, 50000);
ir([1, 1000, 5000]) = [1, 0.8, 0.7];% create an impulse response
[sig, fs] = audioread('pluck.wav'); %Read Signal
%sound(sig,fs);
y = conv(sig, ir); % convolve the two signals
%sound(y,fs);
subplot(211), plot(sig);
subplot(212), plot(y);
conv_pluck = y./max(abs(y));
audiowrite ('conv_pluck.wav', conv_pluck, 44100);
% plot both signals on same figure.