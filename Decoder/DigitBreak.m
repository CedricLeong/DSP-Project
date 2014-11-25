%This program detects the start and end points of any significant points
%in the time domain. It checks for the average, and compares based off
%that.

%This function will fill two arrays. startP and endP are the two arrays
%which will recieve the start and the end of each tone.

%Each tone is is detected by using a windowing technique. This technique is
%implemented by sampling the signal with 200 samples. This creates a window
%of 200 samples which is then compared to the average of the entire signal.

%The array, startP, will be given a value when any sample in the window is 
%greater than the average. 
%The array, endP, will be given a value when any sample in the window is 
%less than the average.

function [startP,endP] = DigitBreak ()


curDir   = pwd; %This is just pathing. Ignore the next three lines.
mainDir  = fileparts(fileparts(curDir));
newPath = fullfile(mainDir, 'DSP-Project', 'Encoder');
addpath (newPath);
close all;

%%Input signal from the tone generator.
Signal = fixed_encoder();


L=length(Signal);%Length of signal
Signal1 = abs(tsmovavg(Signal,'s',9,1));%Filters signal with a moving average 
Signal=abs(Signal);%Computes the absolute of the signal
AVG=mean(Signal);%Computes the average of the time domain signal
startP=[];%Start point array
endP=[];%End point array
i=1;
L=L-100;
    while i <= L
        
        test=Signal1(i)>AVG; %A sample in the window is compared to the AVG
        if test==1          %If a sample is greater than AVG, then save
         startP=[startP i]; %adds sample to start array
         
         %This loop creates a 200 sample window and compares the samples
         %to the average
            for k=i:L
                testarray=Signal1(k:(k+100)); %creates a 200 sample window 
                test1=testarray>AVG;
                sumarray=sum(test1);
                if sumarray==0 %If all 200 samples are lower than average
                    endP=[endP k]; %mark this as an end point
                    i=k; %set i to the location of end point
                    break
                end
            end
        end
        i=i+1;
    end
L2=length(startP);
L3=length(endP);
distances=[];
%This loop calulates the distances between the start and end point
if L2~=L3
    startP=startP(1:L3);
end
for i=1:L3 
    A1=startP(i);
    B1=endP(i);
    distances=[ distances (B1-A1)];
end
fprintf('Estimated length of each signal is:')
distances

%This loop will reject signals for any value less than 39ms and greater
%than 56ms.
Error_check=0;
for i=1:L3
    A1=startP(i);
    B1=endP(i);
    if (B1-A1)>560
        startP(i)=[0];
        endP(i)=[0];
        Error_check=Error_check+1;
    end
    if (B1-A1)<390
        startP(i)=[0];
        endP(i)=[0];
        Error_check=Error_check+1;
    end
    
end
for i=1:(L3-1)
    B1=endP((i));
    A2=startP(i+1);
    if (A2-B1)>565
        startP(i)=[0];
        endP(i)=[0];
        Error_check=Error_check+1;
    end
    if ((A2-B1)<385) && ((A2-B1)>10)
        startP(i)=[0];
        endP(i)=[0];
        Error_check=Error_check+1;
    end
end

if Error_check > 5
    fprintf('Many invalid tones detected')
    disp(char(10))
end
    
endP(endP==0)=[];
startP(startP==0)=[];
TF1 = isempty(startP);
TF2 = isempty(endP);

if TF1 == 1
    startP=[1];
end
if TF2 == 1
    endP=[2];
end
end


