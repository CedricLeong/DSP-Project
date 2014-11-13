close all
[a,b] = GoertzelFilter;
sizesA = size(a);
sizesB = size(b);
b = transpose(b)*10;
col = sizesA(1,2);
f = [75 100 150 200 300 400 500];
for i=1:col
    
stem(f,abs(a((1:7),i)));
figure;


end
