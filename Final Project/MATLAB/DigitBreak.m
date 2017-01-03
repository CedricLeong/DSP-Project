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

%If the start and end arrays are mismatched in length, force them to be the same.
%This is done by discarding any indexed terms greater than L3 in startP 
if L2~=L3
    startP=startP(1:L3);
end

%This loop calulates the distances between the start and end point
for i=1:L3 
    A1=startP(i);
    B1=endP(i);
    distances=[distances (B1-A1)];
end
fprintf('Estimated length of each signal is:')
distances


Error_check=0;

%These vectors are here to delete any invalid entries based on D, duration or S, silence spacing
%These vectors will be then multiplied element wise against the startP and endP arrays. 
startValidD = ones(1,L3); 
startValidS = ones(1,L3);
endValidD = ones(1,L3);
endValidS = ones(1,L3);

for i=1:L3 %Detecting signal duration
    A1=startP(i);
    B1=endP(i);
    if (B1-A1)>560 || (B1-A1)<390 %Remove from array if too long or too short
        startValidD(i)=[0];
        endValidD(i)=[0];
        Error_check+=1;
    end
end

for i=1:(L3-1)%Detecting silence duration
    B1=endP((i));
    A2=startP(i+1);
    if (A2-B1)>565 || (A2-B1)<385 %Delete previous number if silence is too large or small
        startValidS(i)=[0];
        endValidS(i)=[0];
        Error_check+=1;
    end
end

%This is a final check for the last silence
B1=endP(L3);
X = L+100-B1;
if (X<385 || X>565)
    startValidS(L3)=[0];
    endValidS(L3)=[0];
end

%Multiply elements to negate entries
endP = endP.*endValidS.*endValidD;
startP = startP.*startValidS.*startValidD;
%Delete any zero elements (this will remove any invalid digits from entering the Goertzel algorithm)
endP(endP==0)=[];
startP(startP==0)=[];

%Notify the user if there are too many errors.
if Error_check > 5
    fprintf('Five or more invalid tones detected, retransmit with less noise for a better result.')
    disp(char(10))
end
    
%If the vector is empty it will fill the vector with random numbers so the functions later wont crash.
if isempty(startP)
    startP=[1];
end
if isempty(endP)
    endP=[2];
end

end


