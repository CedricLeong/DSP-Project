
To run this MATLAB script follow the steps below:

1. Open fixed_encoder.m.
2. Set parameters:
	num = 'enterstringhere' , 'enterstringhere' should contain no spaces.
	DigitPeriod = [x,y,z], 'x,y,z' are in ms, this is the duration of the digit.
	SilentPeriod = [x,y,z], 'x,y,z' are in ms, this is the duration of the silence between digits.
	Noise = x, 'x' is a real number, this is in decibels
3. Save fixed_encoder.m.
4. Run DigitOutput in MATLABs command window by typing "DigitOutput".


To run the Simulink file follow the steps below:

1. Open BinaryArray.m.
2. Set parameters:
	num = 'enterstringhere' , 'enterstringhere' should contain no spaces.
	DigitPeriod = [x,y,z], 'x,y,z' are in ms, this is the duration of the digit.
	SilentPeriod = [x,y,z], 'x,y,z' are in ms, this is the duration of the silence between digits.
3. Save and run file by typing "BinaryArray.m" in MATLABs command window.
4. Open  FullSystem.slx.
5. To adjust noise, go to the block Encoder>Noise>Band-Limited White Noise and adjust noise power.

