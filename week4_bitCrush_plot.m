fs = 44100;
ts = 1/fs;
dur = 1;
NumberOfSteps = 144;
% This is the number of steps we want to create in our signal
% IE: the resolution.
t = 0:ts:dur;
% This will create a straight line.
% We will use this to demonstrate our transfer function.
subplot(211), plot(x); grid on; hold on;
y = t*NumberOfSteps;
% y is the x value, scaled by the number of steps.
y = round(y);
% y is then rounded to the steps.
y = y*(1/NumberOfSteps);
% we then divide by 1 to normalise the signal.
plot(y, '--');
% plot our new signal with a dashed line.
z = sin(2*pi*1.*t);
subplot(212), plot(z); grid on; hold on;
NumberOfSteps2 = 14;
y2 = z*NumberOfSteps2;
y2 = round(y2);
y2 = y2*(1/NumberOfSteps2);
plot(y2, '--');

audiowrite ("Bitcrush.wav",y2,fs)