function [A] = PhoneNumber(telNum)
   
    numDigits = length(telNum);
    table = [100 200 300;  % number 1
             100 200 400; % number 2
             100 200 500; % number 3
             100 150 300; % number 4
             100 150 400; % number 5
             100 150 500; % number 6
             75 200 300; % number 7
             75 200 400; % number 8
             75 200 500; % number 9
             75 150 300];% number 0


    for (i=1:1:numDigits)

        %Choose number from input array
        freqNum = telNum(i);
        %Select frequencies for the number inputted
        f1 = table (freqNum,1);
        f2 = table (freqNum,2);
        f3 = table (freqNum,3);

        %Determine length of signal, 40-60ms 
       % rnd = (55-40)*rand(1) + 55;

        %Create time vector according to random length
        t = 0:.001:2*pi;

        %Convolve the frequencies using the length. Sort signal in array, each
        %number has it's own column.
        sig = conv(sin(2*pi*f1*t),conv(sin(2*pi*f2*t), sin(t*2*pi*f3)));
        sigT = transpose(sig);
        A(i) = sigT;
    end
end
