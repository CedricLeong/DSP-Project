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
AVG=mean(Signal)%Computes the average of the time domain signal
startP=[];%Start point array
endP=[];%End point array
i=1;
    while i <= L-200
        
        test=Signal1(i)>AVG; %A sample in the window is compared to the AVG
        if test==1          %If a sample is greater than AVG, then save
         startP=[startP i]; %adds sample to start array
         
         %This loop creates a 200 sample window and compares the samples
         %to the average
            for k=i:(L-200)
                testarray=Signal1(k:(k+200)); %creates a 200 sample window 
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
    distances=[];
%This loop calulates the distances between the start and end point    
for i=1:L2 
    A1=startP(i);
    B1=endP(i);
    distances=[ distances (B1-A1)];
end
fprintf('Estimated length of each signal is:')
distances

%This loop will reject signals for any value less than 39ms and greater
%than 56ms.
for i=1:L2
    A1=startP(i);
    B1=endP(i);
    if (B1-A1)>560
        startP(i)=[0];
        endP(i)=[0];
        fprintf('Digit %d was rejected due to length constraints.',i);
        fprintf('Please shorten the length.')
        disp(char(10))
    end
    if (B1-A1)<390
        startP(i)=[0];
        endP(i)=[0];
        fprintf('Digit %d was rejected due to length constraints.',i);
        fprintf('Please increase the length.')
        disp(char(10))
    end
    
end
endP(endP==0)=[];
startP(startP==0)=[];
% This part of the code was put here to check spacing
% This will be implement if rejecting spacing makes sense
% for i=1:l2
%     B1=endP((i));
%     A2=startP(i+1);
%     if (B1-A2)>610
%         
%        
%     end
%     if (B1-A2)<390
%        
%         
%     end
%     
% end
end


