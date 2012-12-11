%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Robert Bowden and Barr Yaron
% Applied Math 120 Final Project
%
% Iterate over a set of wav files, etc...
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

recognition_threshold = 0;

% make sure the script is running in the appropriate directory
if ~exist('recordings', 'dir')
    error('Recordings directory not found.');
end

files = dir('recordings');


wavs = {};
num_files = 0;
lengths = [];
for i = 1:length(files)
    filename = strcat('recordings/', files(i).name);
    try
        wav = wavread(filename);
    catch err
    	continue;
    end

    num_files = num_files + 1;

    % cut off leading and trailing zeros
    first = find(wav ~= 0, 1, 'first');
    last = find(wav ~= 0, 1, 'last');
    wav = wav(first:last);

    wavs{num_files} = wav;
    lengths(num_files) = length(wav);

    %% do stuff with the wav
    %% can either 0-extend or extend entire thing??
    %% average length vs max length
end

% can't do anything if we don't have any recordings
if length(files) == 2
    error('No wav files found in the recordings directory.');
end


max_length = max(lengths);

pca_matrix = zeros(max_length, length(wavs));
for i = 1:length(wavs);
    pca_matrix(1:length(wavs{i}), i) = wavs{i}';
end

% the mean sound
mean_voice = mean(pca_matrix, 2);

%pca_matrix = repmat

[pc, score, latent] = princomp(pca_matrix);

% cumulative variances
cumsum(var(score)) / sum(var(score))

% get the original voices in terms of the eigenvoices
score \ pca_matrix

% applying a gaussian
% loop, reading in some wav file and then matching against previous??
% compression??
while 1
    break;
end
