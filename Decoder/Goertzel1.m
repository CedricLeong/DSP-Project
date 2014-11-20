function [AbsoluteOutput]=Goertzel1(signal)

x=signal;
S=400;                              % N value
f=[75 100 150 200 300 400 500];     % Filter Bank
N=[(f*S/8000)];                     % generates the K values
N=round(N);                         % rounds K values into an integer

%create band pass filters
b75=[1];
a75=[1 -2*cos(2*pi*N(1)/S) 1];
b100=[1];
a100=[1 -2*cos(2*pi*N(2)/S) 1];
b150=[1];
a150=[1 -2*cos(2*pi*N(3)/S) 1];
b200=[1];
a200=[1 -2*cos(2*pi*N(4)/S) 1];
b300=[1];
a300=[1 -2*cos(2*pi*N(5)/S) 1];
b400=[1];
a400=[1 -2*cos(2*pi*N(6)/S) 1];
b500=[1];
a500=[1 -2*cos(2*pi*N(7)/S) 1];
%plot freq response of BPF
% [w1, f]=freqz([1 -exp(-2*pi*N(1)/S)],a75,512,8000);
% [w2, f]=freqz([1 -exp(-2*pi*N(2)/S)],a100,512,8000);
% [w3, f]=freqz([1 -exp(-2*pi*N(3)/S)],a150,512,8000);
% [w4, f]=freqz([1 -exp(-2*pi*N(4)/S)],a200,512,8000);
% [w5, f]=freqz([1 -exp(-2*pi*N(5)/S)],a300,512,8000);
% [w6, f]=freqz([1 -exp(-2*pi*N(6)/S)],a400,512,8000);
% [w7, f]=freqz([1 -exp(-2*pi*N(7)/S)],a500,512,8000);
% plot(f,abs(w1), f,abs(w2), f,abs(w3), f,abs(w4) ,f,abs(w5) ,f,abs(w6));grid
% xlim([0 500])
% xlabel('Frequency (Hz)');

% Filter bank frequency responses
SigFilt=[x];
y75=filter(1,a75,SigFilt);
y100=filter(1,a100,SigFilt);
y150=filter(1,a150,SigFilt);
y200=filter(1,a200,SigFilt);
y300=filter(1,a300,SigFilt);
y400=filter(1,a400,SigFilt);
y500=filter(1,a500,SigFilt);
plot(y400)

% Determines the absolute magnitudes of DFT coefficents
m(1)=sqrt(y75((S-1))^2+y75(S)^2- ...
     2*cos(2*pi*18/S)*y75((S-1))*y75(S));
m(2)=sqrt(y100((S-1))^2+y100(S)^2- ...
     2*cos(2*pi*20/S)*y100((S-1))*y100(S));
m(3)=sqrt(y150((S-1))^2+y150(S)^2- ...
     2*cos(2*pi*22/S)*y150((S-1))*y150(S));
m(4)=sqrt(y200((S-1))^2+y200(S)^2- ...
     2*cos(2*pi*24/S)*y200((S-1))*y200(S));
m(5)=sqrt(y300((S-1))^2+y300(S)^2- ...
     2*cos(2*pi*31/S)*y300((S-1))*y300(S));
m(6)=sqrt(y400((S-1))^2+y400(S)^2- ...
     2*cos(2*pi*34/S)*y400((S-1))*y400(S));
m(7)=sqrt(y500((S-1))^2+y500(S)^2- ...
     2*cos(2*pi*38/S)*y500((S-1))*y500(S));
m=2*m/S;               %Converts DFT magnitude to the single sided spectrum

%Below used to plot the single sided spectrum for testing purposes
% avg=mean(m);  
% f=[75 100 150 200 300 400 500];
% f1=[0:500];
% x1=[1:500];
% % plot output
% figure
% stem(f,m);grid
% hold; plot(x1,avg);
% xlabel('Frequency (Hz)');
% ylabel('Absolute output values');
AbsoluteOutput=m;
