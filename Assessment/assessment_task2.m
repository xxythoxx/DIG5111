% Open file selection dialog for the audio file to filter
[filename1, pathname1] = uigetfile({'*.wav';'*.mp3';'*.flac'}, 'Select the first audio file');
if isequal(filename1,0)
    disp('User canceled the file selection.');

  % Read the selected audio file
    filepath1 = fullfile(pathname1, filename1);
    [unfiltered, Fs] = audioread(filepath1);
    disp(['Loaded ', filename1]);

filtType = lower(input(['Choose the filter type you wish to create, ' ...
    'Low-Pass (LP),High-Pass (HP), Band-Stop (BS) or Notch (N): ']))
if ~ismember(filtType,('LP','HP','BS','N'))
    error ('please enter a specified filter type as written (LP, BP, BS, N)');
end

filtCut = input('Please Specifiy a cutoff frequency (HZ)');
if filtCut >=0 || filtCut >= Fs/2
    error (['Cutoff Frequency needs to be above 0 and below the Nyquist ' ...
        '(1/2 of Sampling Rate']);
end


cutoffNorm = filtCut / (Fs/2);

[b,a] = cheby1(filtOrder,cutoffNorm,'LP') %for lowpass chebyshev
[b,a] = butter(filtOrder,cutoffNorm,'LP') %for lowpass butterworth


filteredAudio = filter(b, a , unfiltered);





