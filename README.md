DSP-Project
===========
This project encodes and decodes a message using three tones below. 
The decoder must:
  Reject tones less than 40ms or greater than 55ms.
  Reject the tone that comes before a silence with a duration of less than 40ms or greater than 60ms.
  Be able to detect tones when noise is added.
  Detect and output the tones fed through the encoder.

This project must be done in both MATLAB and Simulink. The frequencies of each digit are shown below. 
10 topics taught in lecture (ELEE 4420 - DSP Theory and Design) must be used.
  *Note the book used for this course was: Digital Signal Processing 3ed, by Allan V. Oppenheim and  Ronald W. Schafer 


Digit Frequencies (Hz)
1     100, 200, 300
2     100, 200, 400
3     100, 200, 500
4     100, 150,300
5     100, 150, 400
6     100, 150, 500
7     75, 200, 300
8     75, 200, 400
9     75, 200, 500
0     75, 150, 300
