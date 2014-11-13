%This program detects the start and end points of any significant points
%in the time domain. It checks for the average, and compares based off
%that.


function [startP,endP] = DigitBreak ()


curDir   = pwd; %This is just pathing. Ignore the next three lines.
mainDir  = fileparts(fileparts(curDir));
newPath = fullfile(mainDir, 'DSP-Project', 'Encoder');
addpath (newPath);
close all;

%%Inputs from other matlab files
Signal = fixed_encoder();


L=length(Signal);%Length of signal
Signal=abs(Signal);%Computes the absoulte of the signal
AVG=mean(Signal);%Computes the average of the time domain signal
startP=[];%Start point array
endP=[];%End point array
i=1;

    while i <= L-100
        test=Signal(i)>AVG; 
        if test==1    
         startP=[startP i];
            for k=i:(L-100)
                testarray=Signal(k:(k+100));
                test1=testarray>AVG;
                sumarray=sum(test1);
                if sumarray==0
                    endP=[endP k];
                    i=k;
                    break
                end
            end
        end
        i=i+1;
    end
    l2=length(startP);
for i=1:l2
    A1=startP(i);
    B1=endP(i);
    if (B1-A1)>600
        startP(i)=[0];
        endP(i)=[0];
    end
    if (B1-A1)<400
        startP(i)=[0];
        endP(i)=[0];
    end
end
endP(endP==0)=[];
startP(startP==0)=[];
end


