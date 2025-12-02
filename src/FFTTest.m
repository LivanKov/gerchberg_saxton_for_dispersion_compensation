dt = System.SYMBOL_PRECISION;

s = System;
s.input.switchToBinary();
s.ingest('1010101010100001');
s.updatePulse(PulseShape.SINC);
s.shapeInput;
pulse = s.currentVals;
t = s.t_vec;

% Compute FFT
Y = fft(pulse);
Y_shifted = fftshift(Y);

% Frequency vector (for plotting)
N = length(t);
fs = 1/dt;
f = (-N/2:N/2-1) * (fs/N);

[~, idx_zero] = min(abs(f));
f(idx_zero);

% SCALE the FFT to match continuous Fourier transform
Y_continuous = Y_shifted * dt;  % Multiply by dt!

% Now plot
subplot(4,1,1);
plot(f, abs(Y_continuous));
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
abs_spec = abs(Y_continuous);
f_pos = f(f_pos_ids);
spec_pos = abs_spec(f_pos_ids);

subplot(4,1,3);
plot(f_pos, spec_pos);
grid on;
title('Magnitude Spectrum');
xlabel('Frequency (Hz)'); ylabel('|FFT|');


% Inverse Fourier-Transform
subplot(4,1,4);
Y2 = [spec_pos(1) spec_pos(2:end)/2 fliplr(conj(spec_pos(2:end)))/2];
X = ifft(Y);

t = (0:length(X)- 1) * dt;
plot(t, X);
grid on;
figure;

% Noise panel 
pulse_noise = ApplyNoise(pulse, 1);
subplot(4, 1, 1);
plot(t, pulse_noise);
title('Time Domain (Noisy)');
xlabel('Time (t)'); ylabel('x(t)');
grid on;

Y_N = fft(pulse_noise);
Y_N_shifted = fftshift(Y_N);

Y_N_Continous = Y_N_shifted * dt;

subplot(4, 1, 2);
plot(f, abs(Y_N_Continous));
xlabel('Frequency (Hz)'); ylabel('|FFT|');
title('Magnitude Spectrum (Noisy)');
grid on;
xlim([-20 20]);

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
total_energy = trapz(f_pos, esd);
desired = total_energy * 0.9;
[val, idx] = find(int > desired, 1);
square_filt = zeros(1, length(f_pos));
square_filt(1:idx - 1) = 1;
subplot(4,1,3);
plot(f_pos, square_filt);
xlim([0 10]);

square_filt_full = zeros(1, length(f));

disp(size(f));
disp(size(square_filt_full));

square_filt_full(ceil(length(f)/2) - idx + 2: ceil(length(f)/2) + idx - 1) = 1;

disp(size(square_filt_full));

subplot(4, 1, 4);
plot(f, square_filt_full);
xlim([-10 10]);
