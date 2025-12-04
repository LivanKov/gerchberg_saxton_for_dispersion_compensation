s = System;
s.input.switchToBinary();
s.ingest('111001');
s.updatePulse(PulseShape.SINC);
s.outputFilter.areaCovered = 99;

s.shapeInput();

s.plot();

[f, spec] = FFT(s.t_vec);

figure;
plot(f, abs(spec));



