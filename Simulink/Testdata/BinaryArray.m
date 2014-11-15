%These binary numbers are the frequency of each numbers frequency 
%ex. The digit 0 has frequencies of 75,150,300
%since [75 100 150 200 300 400 500]
%then  [1   0   1   0   1   0   0 ] 
X=[1 0 1 0 1 0 0;
0 1 0 1 1 0 0;
0 1 0 1 0 1 0;
0 1 0 1 0 0 1;
0 1 1 0 1 0 0;
0 1 1 0 0 1 0;
0 1 1 0 0 0 1;
1 0 0 1 1 0 0;
1 0 0 1 0 1 0;
1 0 0 1 0 0 1];

num= '1234567890';
LengthN = length(num);
duration = [50,50,50,50,50,50,50,50,50,50];
silence = [50,50,50,50,50,50,50,50,50,50];
binArray = [];

for i=1:LengthN 
%These statements pull the appropriate binary frequencies vector
    if (num(i)=='0') 
        numArray = X(1,1:7);
    elseif (num(i)=='1')
        numArray = X(2,1:7);
    elseif (num(i)=='2')
        numArray = X(3,1:7);
    elseif (num(i)=='3')
        numArray = X(4,1:7);
    elseif (num(i)=='4')
        numArray = X(5,1:7);
    elseif (num(i)=='5')
        numArray = X(6,1:7);
    elseif (num(i)=='6')
        numArray = X(7,1:7);
    elseif (num(i)=='7')
        numArray = X(8,1:7);
    elseif (num(i)=='8')
        numArray = X(9,1:7);
    else (num(i)=='9')
        numArray = X(10,1:7);
    end
 
%creates/adds to an array with each frequency for the duration specified by
%adding itself to the array for duration(x)
    for k=1:duration(i) 
        binArray = [binArray;numArray]; 
    end
%pads the signal array with silence(x) the same way that was done above    
    for j=1:silence(i)
        zero = [0 0 0 0 0 0 0];
        binArray = [binArray; zero];
    end

end

t = length(binArray);
t = 1:t;
t = transpose(t);

ts = timeseries(binArray,t);
save binArray.MAT -v7.3 ts;