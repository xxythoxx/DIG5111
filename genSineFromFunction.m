Amp = 0.9;
f = 441;
fs = 44100;
ts = 1/fs;
t = 0:1/fs:(0.1-ts);
sig = Amp*sin(2*pi*f*t);
sound(sig,fs);
plot(t,sig);
audiowrite("sine1.wav",sig,fs);


x = [ 1 2 3 4 ];
y = [ 10 15 20 25 ];
figure(1);
plot(x,y,'g-*');
figure(2);
stem(x,y,'g-*');
