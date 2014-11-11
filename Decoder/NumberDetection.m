%NumberDetection 
%This function will detect a number based on amplitude given that the time 
%is between 40-55ms. To do this we will sample the signal at 8kHz and if 
%the number of samples is greater than X, with an amplitude of >=1, then
%this will be detected as a number. 


function  NumberDetection() 
	curDir   = pwd; %This is just pathing. Ignore the next three lines.
	mainDir  = fileparts(fileparts(curDir));
	newPath = fullfile(mainDir, 'DSP-Project', 'Encoder');
	addpath (newPath);


	Signal = encoderdsp (); %Fetch the signal from the encoder
	len = length(Signal);	%Get length of signal 
	Fs = 8000; %Sampling frequency

	Wp75 = [60,90]/4000; Ws75 = [50,100]/4000;
	Rp75 = 2; Rs75 = 60;
	[n75,Wp75] = ellipord (Wp75,Ws75,Rp75,Rs75);
    [b,a] = ellip(n75,Rp75,Rs75,Wp75);          % Elliptic filter design
    freqz(b,a,512,8000)                 % Plots the frequency response


end		

  % % Example 2:
  %   %   Design a bandpass filter with a passband of 60 Hz to 200 Hz, with 
  %   %   less than 3 dB of ripple in the passband, and 40 dB attenuation in 
  %   %   the stopbands that are 50 Hz wide on both sides of the passband.
 
  %   Wp = [60 200]/500; Ws = [50 250]/500;
  %   Rp = 3; Rs = 40;
  %   [n,Wp] = ellipord(Wp,Ws,Rp,Rs)      % Gives mimimum order of filter      
  %   [b,a] = ellip(n,Rp,Rs,Wp);          % Elliptic filter design
  %   freqz(b,a,512,1000)                 % Plots the frequency response