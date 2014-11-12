%RetifyingFilter 
%This function will detect a number based on amplitude given that the time 
%is between 40-55ms. To do this we will sample the signal at 8kHz and if 
%the number of samples is greater than X, with an amplitude of >=1, then
%this will be detected as a number. 

%Inputs: A signal (matrix) generated from encoderdsp.m
%Outpts: A signal (matrix) filtered, variable name "Signal"


function [Signal] = RectifyingFilter() 
	curDir   = pwd; %This is just pathing. Ignore the next three lines.
	mainDir  = fileparts(fileparts(curDir));
	newPath = fullfile(mainDir, 'DSP-Project', 'Encoder');
	addpath (newPath);

	close all;
	[Signal,No] = fixed_encoder (); %Fetch the signal from the encoder
	len = length(Signal);	%Get length of signal 
	

    Fs = 10000; %Sampling frequency
    T = 1/Fs; % Sample time
    L = length(Signal);
    t = (0:L-1)*T;% Time vector

    NFFT = 2^nextpow2(L);
    Y = fft(Signal,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);
    % plot(f,2*abs(Y(1:NFFT/2+1))) 

  

    % plot(abs(fft(Signal)));

    Sig1 = filterr(Signal);
    figure;
    L = length(Sig1);
    Y = fft(Sig1,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);
    plot(f,2*abs(Y(1:NFFT/2+1)));
    title('75Hz');
    axis([0 500 0 1]);
    figure

	Wp100 = [60,140]/(0.5*Fs); Ws100 = [30,260]/(0.5*Fs);
	Rp100 = 2; Rs100 = 60;
	[n100,Wp100] = ellipord (Wp100,Ws100,Rp100,Rs100);
    [b100,a100] = ellip(n100,Rp100,Rs100,Wp100);   
    % freqz(b100,a100,512,Fs);
    % title('WP100');
    % figure;
    Sig2 = filter(b100,a100,Signal);
    Y = fft(Sig2,NFFT)/L;
    plot(f,2*abs(Y(1:NFFT/2+1))) 
    title('100Hz');
    axis([0 500 0 1]);


 %    Wp150 = [130,170]/(0.5*Fs); Ws150 = [100 190]/(0.5*Fs);
 %    Rp150 = 2; Rs150 = 60;
 %    [n150,Wp150] = ellipord (Wp150,Ws150,Rp150,Rs150);
 %    [b150,a150] = ellip(n150,Rp150,Rs150,Wp150);
 %    % freqz(b150,a150,512,Fs);   
 %    % title('WP150');
 %    figure;
 %    Sig3 = fft(filter(b150,a150,Signal));
 %    Y = fft(Sig3,NFFT)/L;
 %    plot(f,2*abs(Y(1:NFFT/2+1)))
 %    title('150Hz');
 %    axis([0 500 0 1]);


 %    Wp200 = [180,220]/(0.5*Fs); Ws200 = [140,260]/(0.5*Fs);
	% Rp200 = 2; Rs200 = 60;
	% [n200,Wp200] = ellipord (Wp200,Ws200,Rp200,Rs200);
 %    [b200,a200] = ellip(n200,Rp200,Rs200,Wp200);
 %    % freqz(b200,a200,512,Fs);   
 %    figure;
 %    Sig4 = fft(filter(b200,a200,Signal));
 %    Y = fft(Sig4,NFFT)/L;
 %    plot(f,2*abs(Y(1:NFFT/2+1))) 
 %    title('200Hz');   
 %    axis([0 500 0 1]);


 %    Wp300 = [280,320]/(0.5*Fs); Ws300 = [260,340]/(0.5*Fs);
	% Rp300 = 2; Rs300 = 60;
	% [n300,Wp300] = ellipord (Wp300,Ws300,Rp300,Rs300);
 %    [b300,a300] = ellip(n300,Rp300,Rs300,Wp300); 
 %    % freqz(b300,a300,512,Fs);   
 %    figure;  
 %    Sig5 = fft(filter(b300,a300,Signal));
 %    Y = fft(Sig5,NFFT)/L;
 %    plot(f,2*abs(Y(1:NFFT/2+1)));
 %    title('300Hz'); 
 %    axis([0 500 0 1]);

 %    Wp400 = [380,420]/(0.5*Fs); Ws400 = [360,440]/(0.5*Fs);
	% Rp400 = 2; Rs400 = 60;
	% [n400,Wp400] = ellipord (Wp400,Ws400,Rp400,Rs400);
 %    [b400,a400] = ellip(n400,Rp400,Rs400,Wp400);  
 %    % freqz(b400,a400,512,Fs);   
 %    figure;  
 %    Sig5 = fft(filter(b300,a300,Signal));
 %    Y = fft(Sig5,NFFT)/L;
 %    plot(f,2*abs(Y(1:NFFT/2+1)));
 %    title('400Hz'); 
 %    axis([0 500 0 1]);
  
 %    Wp500 = [480,520]/(0.5*Fs); Ws500 = [460,540]/(0.5*Fs);
	% Rp500 = 2; Rs500 = 60;
	% [n500,Wp500] = ellipord (Wp500,Ws500,Rp500,Rs500);
 %    [b500,a500] = ellip(n500,Rp500,Rs500,Wp500);   
 %    % freqz(b500,a500,512,Fs);   
 %    figure;  
 %    Sig5 = fft(filter(b300,a300,Signal));
 %    Y = fft(Sig5,NFFT)/L;
 %    plot(f,2*abs(Y(1:NFFT/2+1)));
 %    title('500Hz');
 %    axis([0 500 0 1]);

end		

