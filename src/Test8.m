clc;close all; clear all;

freq = 5;
samp_time = 100;
fs = 200;

N_plots = 7;

t = -samp_time/2:1/fs:samp_time/2;
% t = 0:1/fs:samp_time;
disp(length(t));
N = length(t);

s = sinc(freq*t) + sinc(freq*(t - 10)) + sinc(freq*(t - 20));
% s = sin(freq*2*pi*t);
disp(length(s));
figure;
subplot(N_plots, 1, 1);
plot(t, s);
title('Original signal');

spec = fftshift(fft(s));
subplot(N_plots,1,2);
f = (-(N/2):(N/2-1)) * fs/N;
plot(f, abs(spec));
xlim([-20 20]);
title('Original magnitude');


SNR = 15;

noise_sig = awgn(s, SNR);
subplot(N_plots,1,3);
plot(t, noise_sig);
text = ['Noisy Signal. SNR: ' num2str(SNR)];
title(text);

subplot(N_plots, 1, 4);
noise_sig_mag = fftshift(fft(noise_sig));
plot(f, abs(noise_sig_mag));
title('Noisy Signal Magnitude');
xlim([-20 20]);



o_f = OutputFilter;
o_f.areaCovered = 99;
designed_filt = o_f.construct(f, spec);

perf_filt = zeros(1, length(f));
idx = abs(f) <= 2.5;
perf_filt(idx) = 1;
subplot(N_plots, 1, 5);
plot(f, designed_filt);
xlim([-20 20]);
title('Perfect Filter');

filtered = designed_filt .* noise_sig_mag;

subplot(N_plots, 1, 6);
plot(f, abs(filtered));
xlim([-20 20]);
title('Filtered Magnitude');

subplot(N_plots, 1, 7);
plot(t, ifft(ifftshift(filtered)));
title('Original Signal reconstructed via IFFT');