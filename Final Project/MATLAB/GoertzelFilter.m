function [dftAllDigi] = GoertzelFilter ()
%This function calls Goertzel1 and filters the signal N times, where N is the length of the startP array
%Informally known as the amount of digits detected.
close all;

%%Inputs from other matlab files
Signal = fixed_encoder();
[startP,endP] = DigitBreak();
%%


numDigit = length(startP); %checks how many digits for later computations.


if numDigit==0
    fprintf('No tones Detected');
    dftAllDigi=0;
end

%This for loop takes 400 samples from the start of the signal and passes it through the Goertzel algorithm.
%It's then transposed in accordance to how our Goertzel1 function operates
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

%The Goertzel output is once more transposed for computations in later calculations.
dftAllDigi=transpose(dftAllDigi);

end
end

