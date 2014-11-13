
curDir   = pwd; %This is just pathing. Ignore the next three lines.
mainDir  = fileparts(fileparts(curDir));
newPath = fullfile(mainDir, 'DSP-Project', 'Encoder');
addpath (newPath);
close all;
Fs = 10e3;
T = 1/Fs;


Signal = fixed_encoder();
N = length(Signal);

f = [75 100 150 200 300 400 500];
freq_indices = round(f/Fs*N) + 1;
dft_data = goertzel(Signal,freq_indices);

stem(f,abs(dft_data));

