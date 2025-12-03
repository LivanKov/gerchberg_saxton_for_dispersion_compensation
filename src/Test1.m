s = System;
s.input.switchToBinary();
s.ingest('1010101010100001');
disp("Input Sequence");
disp(s.input.stream);
s.updatePulse(PulseShape.COS_SQR);
s.shapeInput;
pulse = s.currentVals;
t = s.t_vec;
disp(length(s.t_vec));
disp(length(s.currentVals));

[f, spec] = FFT(pulse);

subplot(4,1,1);
plot(f, abs(spec));
xlabel('Frequency (Hz)'); ylabel('|FFT|');
title('Magnitude Spectrum');
grid on;
xlim([-20 20]);  % Zoom in to see sinc structure


subplot(4,1,2);
plot(t, pulse);
grid on;
title('Time Domain');
grid on;
xlabel('Time (t)'); ylabel('x(t)');


f_pos_ids = f >= 0;
abs_spec = abs(spec);
f_pos = f(f_pos_ids);
spec_pos = abs_spec(f_pos_ids);

subplot(4,1,3);
plot(f_pos, spec_pos);
grid on;
title('Magnitude Spectrum');
xlabel('Frequency (Hz)'); ylabel('|FFT|');


% Inverse Fourier-Transform
subplot(4,1,4);

[t_new, x_new] = IFFT(spec);

plot(t_new, x_new);
title("Time Domain (Reconstructed via IFFT)");
xlabel('Time (t)'); ylabel('x(t)');
grid on;

% 90% esd filter

esd = abs(spec_pos) .^ 2;
figure;
subplot(4,1,1);
plot(f_pos, esd);
xlim([0 10]);

int = cumtrapz(f_pos, esd);

subplot(4,1,2);
plot(f_pos, int);
xlim([0 10]);



s.outputFilter.areaCovered = 90;
square_filter = s.outputFilter.construct(f, spec);

square_filter_2 = s.outputFilter.construct(f, spec);

custom_filt = s.applyOutputFilter();

subplot(4, 1, 3);
plot(f_pos, square_filter(f_pos_ids));
xlim([0 20]);

subplot(4, 1, 4);
plot(f, square_filter);
xlim([-10 10]);


figure;

% Noise panel 
s.addNoise(1);
pulse_noise = s.currentVals;
subplot(4, 1, 1);
plot(t, pulse_noise);
title('Time Domain (Noisy)');
xlabel('Time (t)'); ylabel('x(t)');
grid on;

[f_noisy_new, spec_noisy_new] = FFT(pulse_noise);

subplot(4, 1, 2);
plot(f_noisy_new, abs(spec_noisy_new));
xlabel('Frequency (Hz)'); ylabel('|FFT|');
title('Magnitude Spectrum (Noisy)');
grid on;
xlim([-20 20]);

filtered = square_filter .* spec_noisy_new;

subplot(4, 1, 3);
plot(f, abs(filtered));
xlabel('Frequency (Hz)'); ylabel('|FFT|');
title('Magnitude Spectrum (Filtered)');
grid on;
xlim([-20 20]);


% Inverse Fourier Transform of the Filtered Magnitude spectrum
subplot(4,1,4);
[t_new_alpha, x_new_alpha] = IFFT(filtered);
plot(t_new_alpha, abs(x_new_alpha));
title("Filtered Time Domain (Reconstructed via IFFT)");
xlabel('Time (t)'); ylabel('x(t)');
grid on;

figure;
plot(f, custom_filt);
title('Custom Filter');
xlim([-20 20]);

figure;
plot(f, square_filter);
title('Square Filter');
xlim([-20 20]);

figure;
plot(f, square_filter_2);
title('Square Filter 2');
xlim([-20 20]);
figure;
s.plot();

res = sampleOutput(t_new_alpha, x_new_alpha)