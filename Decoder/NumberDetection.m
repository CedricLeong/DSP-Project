%NumberDetection 
%This function will detect a number based on amplitude given that the time 
%is between 40-55ms. To do this we will sample the signal at 8kHz and if 
%the number of samples is greater than X, with an amplitude of >=1, then
%this will be detected as a number. 

%The function will then discard samples 20% of the samples from each end. 
%Doing this we will have a signal of maximum length of 33ms and minimum
%length of 24ms. Cutting the signal view from each end will help us distinguish 
%what is the signal by discarding any noise before or after.

%Note this is NOT a filter, just a precursor to being filtered.

function [A] = NumberDetection() 

	Signal = encoderdsp (); %Fetch the signal from the encoder
	len = length(Signal);	%Get length of signal 
	Fs = 8000; %Sampling frequency

	for (l:len) 

		if (abs(Signal(1,l)) >=1) 
			j=0; %Counter for number of samples with abs >=1

			for k=l:len %check the rest of the array for a signal with
				j++;		  %abs >=1 and capture in an array. 
				B (1,j) = Signal(1,k);

				if (abs(Signal(k))<1) %If the signal is small, discard results

					break;
				end

			end

		end
	end
end		


