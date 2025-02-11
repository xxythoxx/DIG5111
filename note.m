function noteX = note (A, keynum, dur)
%function note () will create a note with sample freq. 11025 Hz 
%by given and key and any time duration
Fs = 11025;
Ts = 1/Fs;
A4 = 440;
ref_key=49; %A4 is 49th piano key
n = keynum-ref_key; %calculate difference between ref_key and 
%input key
freq = A4*2^(n/12); %calculate freq. of input key
Time = 0:Ts:dur;

noteX = A*sin(2*pi*freq*Time);
end

