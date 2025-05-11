% Load the audio file
[filename, pathname] = uigetfile({'*.wav';'*.mp3';'*.flac'}, 'Select the audio file');
if isequal(filename, 0)
    disp('User canceled the file selection.');
    return;
end

% Read the audio file
filepath = fullfile(pathname, filename);
[unfiltered, Fs] = audioread(filepath);
disp(['Loaded ', filename]);

% Convert stereo to mono (if applicable)
unfiltered = mean(unfiltered, 2); % Convert to mono by averaging channels

% Display the frequency spectrum (0 - 20 kHz)
figure;
n = length(unfiltered);
f = (0:n-1)*(Fs/n);  % Frequency axis
Y = fft(unfiltered); % FFT of the audio signal
subplot(2,1,1);
semilogx(f(1:floor(n/2)), abs(Y(1:floor(n/2))));
title('Frequency Spectrum (0 - 20 kHz)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0, 20000]);
ytickformat('%.0f');
xtickformat('%.0f');

% Allow user to identify noise frequencies
disp('Analyze the frequency spectrum to identify noise frequencies.');
disp('Press Enter to proceed after identifying noise frequencies.');
pause;

% Filter type and cutoff selection
filtType = lower(input('Choose the filter type (Low-Pass (LP), High-Pass (HP), or Band-Stop (BS)): ', 's'));
if ~ismember(filtType, {'lp', 'hp', 'bs'})
    error('Invalid filter type. Please enter one of LP, HP, BS.');
end

% Filter cutoff(s)
if strcmp(filtType, 'bs')
    cutoff = input('Enter two cutoff frequencies [low high] in Hz: ');
    Wn = cutoff / (Fs / 2); % Normalize cutoff frequencies
else
    cutoff = input('Enter cutoff frequency in Hz: ');
    Wn = cutoff / (Fs / 2); % Normalize cutoff
end

% order input and validation
filtOrder = input('Enter filter order (positive integer): ');
if filtOrder < 1 || mod(filtOrder, 1) ~= 0
    error('Filter order must be a positive integer.');
end

% filter type choice (Butterworth or Chebyshev)
filterDesign = lower(input('Choose filter design (butter or cheby1): ', 's'));
if strcmp(filterDesign, 'butter')
    if strcmp(filtType, 'lp')
        [b, a] = butter(filtOrder, Wn, 'low');
    elseif strcmp(filtType, 'hp')
        [b, a] = butter(filtOrder, Wn, 'high');
    elseif strcmp(filtType, 'bs')
        [b, a] = butter(filtOrder, Wn, 'stop'); % 'stop' instead of 'bs'
    end
elseif strcmp(filterDesign, 'cheby1')
    if strcmp(filtType, 'lp')
        [b, a] = cheby1(filtOrder, 0.5, Wn, 'low');  % Default ripple = 0.5 dB
    elseif strcmp(filtType, 'hp')
        [b, a] = cheby1(filtOrder, 0.5, Wn, 'high');
    elseif strcmp(filtType, 'bs')
        [b, a] = cheby1(filtOrder, 0.5, Wn, 'stop'); % 'stop' instead of 'bs'
    end
else
    error('Invalid filter design. Please choose butter or cheby1.');
end

% apply filter to audio signal
filteredAudio = filter(b, a, unfiltered);

% save  filtered audio
outputPath = fullfile(pathname, ['filtered_', filename]);
audiowrite(outputPath, filteredAudio, Fs);
disp(['Filtered audio saved to: ', outputPath]);

%  plays filtered audio
sound(filteredAudio, Fs);
disp('Playing filtered audio...');

