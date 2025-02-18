 
filename = 'sinewave_A.wav'; 
%reading in the sinewave audio file
[sig, Fs] = audioread (filename);
%Sig stores raw audio data in column;

y = sig';
ts = 1/fs;
t = 0:1/fs:(0.1-ts);
x= t; 
plot(x, y, '--'), hold on;
% we set up 2 straight vectors, to demonstrate the transfer function.
% x holds the original signal, y will hold the new clipped signal.
xLength = length (x);
% we find the length of the input;
for i = 1:xLength
if (y(i) > 0.5)
y(i) = 0.5;
end % if the input is higher than 0.5, the output is clipped at 0.5
if (y(i) < -0.5)
y(i) = -0.5;
end % if the input is lower than -0.5, the output is clipped at -0.5
end

plot(x,y); 
title('Transfer Function for Hard Clipping Distortion');
grid on;
hold off;

audiowrite ("clip_sineA.wav",y,fs)


clip2 = sig';
for i = 1:xLength
if (y(i) < -0.1)
clip2(i) = -0.1;
end
end
plot(clip2), axis([1, xLength, -1, 1]); grid on; hold off;
audiowrite ("NegativeClip_SineA.wav",sig',fs)