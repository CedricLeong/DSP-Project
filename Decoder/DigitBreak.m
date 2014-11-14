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
% figure
% plot(Signal);
% hold
% plot((1:L), AVG)

    while i <= L-200
        test=Signal(i)>AVG; 
        if test==1    
         startP=[startP i];
            for k=i:(L-200)
                testarray=Signal(k:(k+200));
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
    distances=[];
for i=1:l2
    A1=startP(i);
    B1=endP(i);
    distances=[ distances (B1-A1)];
end
fprintf('Estimated length of each signal is:')
distances
for i=1:l2
    A1=startP(i);
    B1=endP(i);
    if (B1-A1)>560
        startP(i)=[0];
        endP(i)=[0];
    end
    if (B1-A1)<390
        startP(i)=[0];
        endP(i)=[0];
    end
    
end
endP(endP==0)=[];
startP(startP==0)=[];
% This part of the code was put here to check spacing
% This will be implement if regecting spacing makes sense
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


