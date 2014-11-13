function [binEnc] = GoertzelFilter ()
%%This is just pathing. Ignore the next four lines.
curDir   = pwd; 
mainDir  = fileparts(fileparts(curDir));
newPath = fullfile(mainDir, 'DSP-Project', 'Encoder');
addpath (newPath);
close all;
%%
%%Inputs from other matlab files
Signal = fixed_encoder();
[startP,endP] = DigitBreak();
%%

%%Setup variables
Fs = 10e3;
T = 1/Fs;
f = [75 100 150 200 300 400 500];
%%

numDigit = length(starP); %checks how many digits for later computations.


freq_indices = round(f/Fs*N) + 1;
dft_data = goertzel(Signal,freq_indices);

stem(f,abs(dft_data));

end

