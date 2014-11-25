function [LogicMatrix] = DigitOutput
close all
clear all 
clc
[a] = GoertzelFilter;
if [a]== 0
    fprintf('An error occured, no tones detected')
end
if [a]~=0
sizesA = size(a);
col = sizesA(1,2);
f = [75 100 150 200 300 400 500];
f1=[0:500];
binaryN= [];
for i=1:col
    array1=a((1:7),i);
    a1=sort(array1,'descend');
    bin1= array1>=a1(3);
    binaryN = [binaryN bin1];
end
binaryNTr= transpose(binaryN);
BTd=bi2de(binaryNTr,'left-msb');


digitMatrix = [0 1 2 3 4 5 6 7 8 9 ; 84 44 42 41 52 50 49 76 74 73];
digitMatrix = digitMatrix(:);
digitMatrix=transpose(digitMatrix);
LenD=length(BTd);
Output=[];
for i =1:LenD
    a=digitMatrix == BTd(i);
    a=circshift(a,[-1,-1]);
    Output=[Output digitMatrix(a)];    
end
if isempty(Output)
	fprintf('No tones Detected.')
else
fprintf('The Decoded Digits are :')
% if Output == 0
%     disp(char(10))
%     fprintf('No Digits Detected')
% end
% if Output ~= 0
%     Output
% end
Output
end
end
end

