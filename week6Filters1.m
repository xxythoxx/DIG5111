NoiseFs = 22050;
NoiseDur = 2;
Noise = randn (44100,1);

a = 1;
b = filter1.Numerator;
stem(b);
newnoise1 = conv(Noise,b);
newnoise2 = filter(b,a, Noise);

sound (newnoise1, NoiseFs);
pause (NoiseDur + 0.5);
sound (newnoise2, NoiseFs);
lenA = length(newnoise1);
lenB = length(newnoise2);
length = abs(lenA - lenB);
disp('difference between A and B')

%sound (Noise,NoiseFs);


filter1

