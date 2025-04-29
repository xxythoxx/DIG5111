%filename1 = input('What file would you like to open? ','s');

% Open file selection dialog for the first audio file
[filename1, pathname1] = uigetfile({'*.wav';'*.mp3';'*.flac'}, 'Select the first audio file');
if isequal(filename1,0)
    disp('User canceled the file selection.');
else
    % Read the selected audio file
    filepath1 = fullfile(pathname1, filename1);
    [audio1, Fs] = audioread(filepath1);
    disp(['Loaded ', filename1]);
end

% Open file selection dialog for the second audio file
[filename2, pathname2] = uigetfile({'*.wav';'*.mp3';'*.flac'}, 'Select the second audio file');
if isequal(filename2,0)
    disp('User canceled the file selection.');
else
    % Read the selected audio file
    filepath2 = fullfile(pathname2, filename2);
    [audio2, Fs2] = audioread(filepath2);
    disp(['Loaded ', filename2]);
end




if Fs ~= Fs2 %if sampling rates are not identical
    choice = menu("sampling rates of files differ",...
        ['resample "' filename1 '" to ' num2str(Fs2)], ...
        ['resample"' filename2 '"to' num2str(Fs)] ,...
        'cancel'); %opens a UI menu where they choose which file to resample
    switch choice %adds a switch choice to allow to resample at other 
     % audio files frequencies
       case 1
           audio1 = resample (audio1, Fs, Fs2);
           Fs2 = Fs;
       case 2
           audio2 = resample (audio2, Fs2, Fs);
           Fs = Fs2;
       otherwise
     error('Sampling frequencies do not match');
    end
end

if Fs>=Fs2  %max plotting frequency
    fMax = Fs/2;
else 
    fMax = Fs2/2;
end

dft = fft(audio1);
mag = abs(dft);
n = length(audio1);     % Length of the first audio signal
f = (0:n-1)*(Fs/n);     % frequency range for spectral analysis

dft2 = fft(audio2);
mag = abs(dft2)
n2 = length(audio2);    %length of the 2nd audio signal
f2 = (0:n2-1)*(Fs2/n2);  % uses Fs)


spec_length= floor(n/2+1);
spec = dft(1:spec_length);
spec_mag = abs(spec);
spec_freq = f(1:spec_length);


spec_length2 = floor(n2/2+1);
spec2 = dft2(1:spec_length2);
spec_mag2 = abs(spec2);
spec_freq2 = f2(1:spec_length2);

figure;
subplot(2,1,1);  % Create a subplot for the first signal
%plot(f, abs(fft(audio1)));  % Plot the FFT of the first signal
plot (spec_freq, spec_mag);

xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Amplitude Spectrum of the First Audio File');

ax = gca;
ax.XAxis.Exponent = 0;  % Turn off scientific notation
xtickformat('%.0f');    % Set the x-axis ticks to be in normal format

% Plot the second audio signal's amplitude spectrum
subplot(2,1,2);  % Create a subplot for the second signal
%plot(f2, abs(fft(audio2)));  % Plot the FFT of the second signal
plot (spec_freq2, spec_mag2);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Amplitude Spectrum of the Second Audio File');

ax2 = gca;
ax2.XAxis.Exponent = 0;  % Turn off scientific notation
xtickformat('%.0f');     % Set the x-axis ticks to be in normal format