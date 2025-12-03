s = System;
s.input.switchToBinary();
s.ingest('1010101010100001');
s.updatePulse(PulseShape.SINC);
s.outputFilter.areaCovered = 99;

s.shapeInput();

s.plot();


s.addNoise(10);

s.plot();

filter = s.applyOutputFilter();

s.plot();

figure;
plot(s.f_vec, filter);


