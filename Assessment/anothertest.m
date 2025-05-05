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

% Stereo to Mono (if applicable)
if size(unfiltered, 2) == 2
    unfiltered = mean(unfiltered, 2); % Convert to mono by averaging channels
end

% Display the time-domain signal
figure;
subplot(2, 1, 1);
plot((1:length(unfiltered)) / Fs, unfiltered);
title('Time-domain Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');

% Compute the Fourier Transform (FFT) of the audio signal
n = length(unfiltered);
f = (0:n-1)*(Fs/n);  % Frequency axis
Y = fft(unfiltered); % FFT of the audio signal
Y_magnitude = abs(Y); % Magnitude of FFT

% Plot the frequency spectrum (Magnitude) for 0-20 kHz with linear scale
subplot(2, 1, 2);
freq_limit = 20000; % 20 kHz limit for human hearing

% Plot only the positive frequencies up to 20 kHz, using linear scale
plot(f(1:min(n/2, freq_limit)), Y_magnitude(1:min(n/2, freq_limit)));
title('Frequency Spectrum (0 - 20 kHz)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Set linear scale for the magnitude axis
set(gca, 'YScale', 'linear'); % Ensure linear scale for magnitude

% Set the x-axis range to 0-20 kHz (Nyquist frequency)
xlim([0, 20000]);

% Remove scientific notation from axis labels
ax = gca;
ax.YAxis.Exponent = 0; % Prevent scientific notation on the y-axis
ax.XAxis.Exponent = 0; % Prevent scientific notation on the x-axis

% Set y-axis ticks to display full values (not powers of 10)
ytickformat('%.0f'); % Display y-axis values without scientific notation
xtickformat('%.0f'); % Display x-axis values without scientific notation

% Optionally, set the x-axis ticks for better readability
set(gca, 'XTick', 0:500:20000); % Adjust x-axis tick marks (can change interval)

% Allow user to interact with the plot and identify noise frequencies
disp('Analyze the frequency spectrum to identify noise frequencies.');
disp('Once you have identified the noise frequencies, press Enter to proceed.');
pause; % Wait for user input to proceed

% User selects filter type and cutoff frequencies
filtType = lower(input('Choose the filter type (Low-Pass (LP), High-Pass (HP), Band-Stop (BS), or Notch (N)): ', 's'));

if ~ismember(filtType, {'lp', 'hp', 'bs', 'n'})
    error('Invalid filter type. Please enter one of LP, HP, BS, N.');
end

% If Band-Stop or Notch, ask for two cutoff frequencies (low and high)
if strcmp(filtType, 'bs') || strcmp(filtType, 'n')
    cutoff = input('Enter two cutoff frequencies as [low high] in Hz: ');
    if length(cutoff) ~= 2 || any(cutoff <= 0) || any(cutoff >= Fs/2)
        error('Frequencies must be within (0, Nyquist).');
    end
    Wn = cutoff / (Fs / 2);  % Normalize the cutoff frequencies
else
    % For LP and HP filters, just use one cutoff frequency
    cutoff = input('Enter cutoff frequency in Hz: ');
    if cutoff <= 0 || cutoff >= Fs/2
        error('Cutoff frequency must be within (0, Nyquist).');
    end
    Wn = cutoff / (Fs / 2);  % Normalize cutoff
end

% Filter order (user input or default)
filtOrder = input('Enter filter order (e.g., 3 for 3rd order): ');

if filtOrder < 1 || mod(filtOrder, 1) ~= 0
    error('Filter order must be a positive integer.');
end

% Choose filter design (Chebyshev or Butterworth)
filterDesign = lower(input('Choose filter design (butter or cheby1): ', 's'));

if strcmp(filterDesign, 'butter')
    if strcmp(filtType, 'lp')
        [b, a] = butter(filtOrder, Wn, 'low');
    elseif strcmp(filtType, 'hp')
        [b, a] = butter(filtOrder, Wn, 'high');
    elseif strcmp(filtType, 'bs') || strcmp(filtType, 'n')
        [b, a] = butter(filtOrder, Wn, 'stop');
    end
elseif strcmp(filterDesign, 'cheby1')
    if strcmp(filtType, 'lp')
        [b, a] = cheby1(filtOrder, 0.5, Wn, 'low');  % Default ripple of 0.5 dB
    elseif strcmp(filtType, 'hp')
        [b, a] = cheby1(filtOrder, 0.5, Wn, 'high');
    elseif strcmp(filtType, 'bs') || strcmp(filtType, 'n')
        [b, a] = cheby1(filtOrder, 0.5, Wn, 'stop');
    end
else
    error('Invalid filter design. Please choose either butter or cheby1.');
end

% Apply the filter to the audio signal
filteredAudio = filter(b, a, unfiltered);

% Save the filtered audio to a new file
outputPath = fullfile(pathname, ['filtered_', filename]);
audiowrite(outputPath, filteredAudio, Fs);
disp(['Filtered audio saved to: ', outputPath]);

%can play it out like this
%sound(filteredAudio, Fs);

