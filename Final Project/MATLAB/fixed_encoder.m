function [Signal] = fixed_encoder()

num= '9057218668'; %user defined number
LengthN = length(num); 
DigitPeriod= [50 50 50 50 50 50 50 50 50 50]; %duration of tones
SilentPeriod= [50 50 50 50 50 50 50 50 50 50]; %silent period after each tone
Noise=100;
%frequencies
List = [75 150 300; 100 200 300; 100 200 400; 100 200 500; 100 150 300; 
    100 150 400; 100 150 500; 75 200 300; 75 200 400; 75 200 500];

        if(LengthN > length(DigitPeriod)||LengthN>length(SilentPeriod))
            fprintf('You have not incuded enough silences and/or duration periods. Please try again.')
            return;
        end
 %Initial Values
            Sampling = 8000; % sampling for sound must be atleast 8000
            T=1/Sampling;
 %Initate variables         
            interval = 50*10;
            Signal = zeros(interval,1);   % Fill Array with Zeros
% generate signal for number number
     for i = 1: LengthN

          duration = DigitPeriod(i)*10; % duration specified in prompt
          interval = SilentPeriod(i)*10; % interval specified in prompt
         % Ns = floor(duration*Sampling);  % signal
         % N0 = floor(interval*Sampling);  % silence period
          %Array of Intervals:
         k = (1:duration)*T;  
         N0=interval;
         number = str2double(num(i)); % convert string to doubles
         %Looks at the values in the List above to see which freqs need to
         %be added for the tone.
         Freq1 = List(number+1,1); 
         Freq2 = List(number+1,2);
         Freq3 = List(number+1,3);
         ToneSignal =(1+ rand(1))*(sin(2.*pi.*Freq1.*k)...
             + (1+ rand(1))*sin(2.*pi.*Freq2.*k)...
             + (1+ rand(1))*sin(2.*pi.*Freq3.*k));  % maximal amplitude is 2
         %Creates a matrix to store all signals computed above into a
         %matrix, ":" operant makes the rows of the maxtrix columbs. and
         %then adds a zeros matrix to fill the "intervals".
         Signal = [Signal; ToneSignal(:); zeros(N0,1)];
     end


length1=length(Signal);
length1=(length1-1)/10;
time_vec=0:.1:length1;
plot(time_vec, Signal); %To see the plot of the original signal without noise, uncomment this line.
xlabel('Time (ms)');
ylabel('Amplitude');
%Add White Noise to Signal:
Signal = awgn(Signal,Noise);
plot(time_vec,Signal) %To see the plot of the signal with noise, uncomment this line
xlabel('Time (ms)');
ylabel('Amplitude');

end