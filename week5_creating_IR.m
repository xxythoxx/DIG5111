t = [0.001, 0.5, 1, 1.5, 2];

Ir = zeros(1,4); %creating IR starting as 4 zeroes

Ir(1) = 1; %makes value 1 equal to 1
%value 2 currently has no assigned value so will still be 0
Ir(3) = 1;%makes value 2 equal to 1
Ir(4) = 0.5; % 4th value in IR is equal to 0.5

Ir(round(Fs*t(1)))=1; %taking the sampling frequency, multiplying by t  
%values, then rounding to nearest full number as index cannot work with
%decimals
Ir(round(Fs*t(2)))=0.7;
Ir(round(Fs*t(3)))=0.25;
Ir(round(Fs*t(4)))=0.17;

figure(1), stem(Ir); %plots the convolution on a stem plot, visualising the
%points