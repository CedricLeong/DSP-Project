close all
clear all
clc


%create a three frequency tone to specifications
Freq1=75;
Freq2=150;
Freq3=300;
Sampling=10000;
duration = 50*1e-3; % duration specified in prompt
Ns = floor(duration*Sampling);
k = 1:Ns;
x=sin(2.*pi.*Freq1.*k./Sampling) + sin(2.*pi.*Freq2.*k./Sampling)+ sin(2.*pi.*Freq3.*k./Sampling);


%create band pass filters
b75=[1];
a75=[1 -2*cos(2*pi*1.5/205) 1];
b100=[1];
a100=[1 -2*cos(2*pi*2.01/205) 1];
b150=[1];
a150=[1 -2*cos(2*pi*3/205) 1];
b200=[1];
a200=[1 -2*cos(2*pi*4/205) 1];
b300=[1];
a300=[1 -2*cos(2*pi*6/205) 1];
b400=[1];
a400=[1 -2*cos(2*pi*8/205) 1];
b500=[1];
a500=[1 -2*cos(2*pi*10/205) 1];
%plot freq response of BPF
[w1, f]=freqz([1 -exp(-2*pi*1.5/205)],a75,512,10000);
[w2, f]=freqz([1 -exp(-2*pi*2.0/205)],a100,512,10000);
[w3, f]=freqz([1 -exp(-2*pi*3.0/205)],a150,512,10000);
[w4, f]=freqz([1 -exp(-2*pi*4./205)],a200,512,10000);
[w5, f]=freqz([1 -exp(-2*pi*6/205)],a300,512,10000);
[w6, f]=freqz([1 -exp(-2*pi*8/205)],a400,512,10000);
[w7, f]=freqz([1 -exp(-2*pi*10/205)],a500,512,10000);
plot(f,abs(w1),f,abs(w2),f,abs(w3), ...
 f,abs(w4),f,abs(w5),f,abs(w6),f,abs(w7));grid
xlabel('Frequency (Hz)');

creates filters
SigFilt=[x];
y75=filter(1,a75,SigFilt);
y100=filter(1,a100,SigFilt);
y150=filter(1,a150,SigFilt);
y200=filter(1,a200,SigFilt);
y300=filter(1,a300,SigFilt);
y400=filter(1,a400,SigFilt);
y500=filter(1,a500,SigFilt);

%not sure what this does
m(1)=sqrt(y75(206)^2+y75(205)^2- ...
     2*cos(2*pi*18/205)*y75(206)*y75(205));
m(2)=sqrt(y100(206)^2+y100(205)^2- ...
     2*cos(2*pi*20/205)*y100(206)*y100(205));
m(3)=sqrt(y150(206)^2+y150(205)^2- ...
     2*cos(2*pi*22/205)*y150(206)*y150(205));
m(4)=sqrt(y200(206)^2+y200(205)^2- ...
     2*cos(2*pi*24/205)*y200(206)*y200(205));
m(5)=sqrt(y300(206)^2+y300(205)^2- ...
     2*cos(2*pi*31/205)*y300(206)*y300(205));
m(6)=sqrt(y400(206)^2+y400(205)^2- ...
     2*cos(2*pi*34/205)*y400(206)*y400(205));
m(7)=sqrt(y500(206)^2+y500(205)^2- ...
     2*cos(2*pi*38/205)*y500(206)*y500(205));
m=2*m/205;
th=sum(m)/4;  %based on empirical measurement
f=[75 100 150 200 300 400 500];
f1=[0  500];
th=[ th th];
x;
%plot output
figure
stem(f,m);grid
hold; plot(f1,th);
xlabel('Frequency (Hz)');
ylabel('Absolute output values');

