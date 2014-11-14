function [AbsoluteOutput]=Goertzel(signal)
%create a three frequency tone to specifications
% Freq1=100;
% Freq2=150;
% Freq3=200;
% Sampling=8000;
% duration = 50*1e-3; % duration specified in prompt
% Ns = floor(duration*Sampling);
% k = 1:Ns;
% x=sin(2.*pi.*Freq1.*k./Sampling) + sin(2.*pi.*Freq2.*k./Sampling)+ sin(2.*pi.*Freq3.*k./Sampling);
x=signal;

%create band pass filters
b75=[1];
a75=[1 -2*cos(2*pi*3/400) 1];
b100=[1];
a100=[1 -2*cos(2*pi*5/400) 1];
b150=[1];
a150=[1 -2*cos(2*pi*7.5/400) 1];
b200=[1];
a200=[1 -2*cos(2*pi*10/400) 1];
b300=[1];
a300=[1 -2*cos(2*pi*15/400) 1];
b400=[1];
a400=[1 -2*cos(2*pi*20/400) 1];
b500=[1];
a500=[1 -2*cos(2*pi*25/400) 1];
%plot freq response of BPF
% [w1, f]=freqz([1 -exp(-2*pi*3/400)],a75,512,8000);
% [w2, f]=freqz([1 -exp(-2*pi*5/400)],a100,512,8000);
% [w3, f]=freqz([1 -exp(-2*pi*7.5/400)],a150,512,8000);
% [w4, f]=freqz([1 -exp(-2*pi*10/400)],a200,512,8000);
% [w5, f]=freqz([1 -exp(-2*pi*15/400)],a300,512,8000);
% [w6, f]=freqz([1 -exp(-2*pi*20/400)],a400,512,8000);
% [w7, f]=freqz([1 -exp(-2*pi*25/400)],a500,512,8000);
% plot(f,abs(w1), f,abs(w2), f,abs(w3), f,abs(w4) ,f,abs(w5) ,f,abs(w6));grid
% xlabel('Frequency (Hz)');

%creates filters
SigFilt=[x];
y75=filter(1,a75,SigFilt);
y100=filter(1,a100,SigFilt);
y150=filter(1,a150,SigFilt);
y200=filter(1,a200,SigFilt);
y300=filter(1,a300,SigFilt);
y400=filter(1,a400,SigFilt);
y500=filter(1,a500,SigFilt);


Lsample=length(y500);
m(1)=sqrt(y75((Lsample-1))^2+y75(Lsample)^2- ...
     2*cos(2*pi*18/400)*y75((Lsample-1))*y75(Lsample));
m(2)=sqrt(y100((Lsample-1))^2+y100(Lsample)^2- ...
     2*cos(2*pi*20/400)*y100((Lsample-1))*y100(Lsample));
m(3)=sqrt(y150((Lsample-1))^2+y150(Lsample)^2- ...
     2*cos(2*pi*22/400)*y150((Lsample-1))*y150(Lsample));
m(4)=sqrt(y200((Lsample-1))^2+y200(Lsample)^2- ...
     2*cos(2*pi*24/400)*y200((Lsample-1))*y200(Lsample));
m(5)=sqrt(y300((Lsample-1))^2+y300(Lsample)^2- ...
     2*cos(2*pi*31/400)*y300((Lsample-1))*y300(Lsample));
m(6)=sqrt(y400((Lsample-1))^2+y400(Lsample)^2- ...
     2*cos(2*pi*34/400)*y400((Lsample-1))*y400(Lsample));
m(7)=sqrt(y500((Lsample-1))^2+y500(Lsample)^2- ...
     2*cos(2*pi*38/400)*y500((Lsample-1))*y500(Lsample));
m=2*m/Lsample;
avg=mean(m);  %based on empirical measurement
f=[75 100 150 200 300 400 500];
f1=[0:500];
x1=[1:500];
% plot output
figure
stem(f,m);grid
hold; plot(x1,avg);
xlabel('Frequency (Hz)');
ylabel('Absolute output values');
AbsoluteOutput=m;
