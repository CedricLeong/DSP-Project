function [LogicMatrix] = DigitOutput
close all
[a] = GoertzelFilter;
absA=abs(a)
sizesA = size(a);
col = sizesA(1,2);
f = [75 100 150 200 300 400 500];
for i=1:col
figure;
stem(f,abs(a((1:7),i)));
end
digitMatrix = [0 1 2 3 4 5 6 7 8 9 ; 84 44 42 41 52 50 49 76 74 73];

end