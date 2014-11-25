function [dftAllDigi] = GoertzelFilter ()
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
numDigit = length(startP); %checks how many digits for later computations.
if numDigit==0
    fprintf('No tones Detected');
    dftAllDigi=0;
end
if numDigit~=0
for i=1:numDigit
    digiArray = Signal(startP(i):(startP(i)+400));
    digiArray = transpose(digiArray);
    dftCurrentDigi = Goertzel1(digiArray); 
    if i==1
        dftAllDigi = dftCurrentDigi;
    else
        dftAllDigi = [dftAllDigi; dftCurrentDigi];
    end
end


dftAllDigi=transpose(dftAllDigi);
end
end

