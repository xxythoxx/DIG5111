[sig_pluck, Fs] = audioread ('pluck.wav'); %reading in the audiofile
[ir, Fsir]=audioread ('church.wav'); %reading in an audio file to convolute with,
%making an impulse response from that file in corrolation to sampling
%frequency

disp(Fs)
disp(Fsir)

[ir2]= resample (ir,Fs, Fsir); % creating another IR where it resamples based off
%of values from all IRs 

y = conv(sig_pluck, ir2(:,1)); % convoluting the pluck audio signal in relation to the
%new impulse response
conv_pluck = y./max(abs(y)) *0.2 ; %normalising the audio

%adding wet/dry controls
     %   wetLevel = 0.5;
      %  y = y(1:length(sig_pluck));
       % dry = sig_pluck;
        %output = (1-wetLevel) * dry + wetLevel * y;
%output = output/max(abs(output));

sound (output,Fs)%playing the sound when code is executed
