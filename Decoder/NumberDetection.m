%NumberDetection 
%This function will detect a number based on amplitude given that the time 
%is between 40-55ms. To do this we will sample the signal at 8kHz and if 
%the number of samples is greater than X, with an amplitude of >=1, then
%this will be detected as a number. The output will be a matrix JxM, where
%J is the amount of digits found and M is samples belonging to that time frame.

%Inputs: A signal (1xN matrix) from RectifyingFilter.m
%Outputs: A signal (JxM matrix), variable name "Signal".


function  NumberDetection() 



end		

