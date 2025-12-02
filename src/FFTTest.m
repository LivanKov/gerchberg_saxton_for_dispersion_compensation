t = -2:0.01:2;
dt = 0.01;

% Rectangular pulse (width T = 1, amplitude A = 1)
pulse = double(abs(t) <= 0.5);

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
plot(f, abs(Y_continuous));

subplot(4,1,1);
plot(f, abs(Y_shifted));
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
abs_spec = abs(Y_shifted);
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

t = (-(length(X)/2):length(X)/2 - 1) * dt;
plot(t, X);
grid on;