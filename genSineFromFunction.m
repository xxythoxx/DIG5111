Fs = 1000;
dur = 1;
freq = 99;
theta = 0;
A = 0.5;
sig = DaveSineWave(A, freq, Fs, dur, theta);
sound(sig, Fs);