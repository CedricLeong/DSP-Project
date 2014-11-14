function [LogicMatrix] = DigitOutput
close all
[a] = GoertzelFilter;
absA=abs(a);
sizesA = size(a);
col = sizesA(1,2);
f = [75 100 150 200 300 400 500];
binaryN= [];
for i=1:col
    AveGoert= mean(absA((1:7),i));
    bin1= absA((1:7),i)>AveGoert;
    binaryN = [binaryN bin1];
%   figure;
%   stem(f,abs(a((1:7),i)));
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
X='The Decoded Digits are : '
Output(:)
    

end

