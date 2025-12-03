s = System;
s.input.switchToBinary();
s.ingest('1010101010100001');
s.updatePulse(PulseShape.COS_SQR);
s.outputFilter.areaCovered = 90;

% s.plot();

s.shapeInput();


% s.plot();

% s.plotFT();

s.addNoise(0.5);

% s.plot();

% s.plotFT();



filter = s.applyOutputFilter();

figure;
subplot(3, 1, 1);
plot(f, filter);
subplot(3, 1, 3);
plot(f, abs(spec));


