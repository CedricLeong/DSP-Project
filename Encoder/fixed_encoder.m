function [Heavy_Noise] = fixed_encoder()

%updated tanvir's code with user defined periods
%the first silent period is fixed to be 50 ms, but can be changed if needed
%we could also let the user define the amount of noise
%also removed harmonic noise

clear all
clc



num= '1234';
LengthN = length(num);
DigitPeriod= [50 50 50 50 50 50 50 50 50 50];
SilentPeriod= [50 50 50 50 50 50 50 50 50 50];

%frequencies
List = [75 150 300; 100 200 300; 100 200 400; 100 200 500; 100 150 300; 100 150 400; 
         100 150 500; 75 200 300; 75 200 400; 75 200 500];
 %Initial Values
            Sampling = 10000; % sampling for sound must be atleast 8000
 %Initate variables         
            interval = 50e-3;
            N0 = floor(interval*Sampling);
            Signal = zeros(N0,1);   % Fill Array with Zeros
% generate signal for number number
     for i = 1: LengthN
          duration = DigitPeriod(i)*1e-3; % duration specified in prompt
          interval = SilentPeriod(i)*1e-3; % interval specified in prompt
          Ns = floor(duration*Sampling);  % signal
          N0 = floor(interval*Sampling);  % silence period
          %Array of Intervals:
         k = 1:Ns;
         number = str2double(num(i)); % convert string to doubles
         %Looks at the valyes in the List above to see which freqs need to
         %be added for the tone.
         Freq1 = List(number+1,1); 
         Freq2 = List(number+1,2);
         Freq3 = List(number+1,3);
         ToneSignal =(1+ rand(1))*(sin(2.*pi.*Freq1.*k./Sampling)...
             + sin(2.*pi.*Freq2.*k./Sampling)...
             + sin(2.*pi.*Freq3.*k./Sampling));  % maximal amplitude is 2
         %Creates a matrix to store all signals computed above into a
         %matrix, ":" operant makes the rows of the maxtrix columbs. and
         %then adds a zeros matrix to fill the "intervals".
         Signal = [Signal; ToneSignal(:); zeros(N0,1)];
     end
%create White Noise to Signal:
Heavy_Noise = awgn(Signal,15);
plot(Heavy_Noise);
        
% %Generate Sound for all signals 1) Normal, 2) Noisy 3) heavily Noisy
%   prompt='press any key to hear original tone'
%         pause;
%         sound(Signal, Sampling)
%   prompt='press any key to hear noisy tone'
%         pause;
%         sound(Light_Noise, Sampling)
%   prompt='press any key to hear heavily noisy tone'
%         pause;
%         sound(Heavy_Noise, Sampling)
%   prompt='end of encoder sequence'
end