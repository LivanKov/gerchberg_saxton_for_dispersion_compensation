%% Three Dirac impulses convolved with a sinc pulse
clear; close all; clc;

% ---------- Parameters ----------
dt   = 0.001;          % time step (sampling interval)
t_x  = -1:dt:3;        % time axis for impulse train (input)
t_h  = -4:dt:4;        % time axis for sinc pulse (impulse response)

% ---------- Input: 3 Dirac impulses at t = 0, 1, 2 ----------
x = zeros(size(t_x));
imp_times = [0 1 2];

for k = 1:numel(imp_times)
    % find index of the sample closest to desired impulse time
    [~, idx] = min(abs(t_x - imp_times(k)));
    x(idx) = 1/dt;  % approximate Dirac: area = 1 (height = 1/dt)
end

% ---------- Impulse response: sinc pulse ----------
% MATLAB's sinc(x) = sin(pi*x) / (pi*x)
h = sinc(t_h);

% ---------- Convolution (numeric approx. of continuous-time conv) ----------
y = conv(x, h) * dt;   % multiply by dt to approximate integral
t_y = (t_x(1) + t_h(1)) : dt : (t_x(end) + t_h(end));  % time axis for y

% ---------- Plots ----------
figure;

% Input (impulses)
subplot(3,1,1);
stem(t_x, x*dt, 'filled');          % multiply by dt so impulses have height 1
xlabel('t'); ylabel('x(t)');
title('Input: 3 Dirac impulses (approximated)');
grid on;

% Sinc pulse
subplot(3,1,2);
plot(t_h, h);
xlabel('t'); ylabel('h(t)');
title('Impulse response: sinc(t)');
grid on;

% Output (three shifted sinc pulses)
subplot(3,1,3);
plot(t_y, y);
xlabel('t'); ylabel('y(t)');
title('Output y(t) = x(t) * h(t): 3 shifted sinc pulses');
grid on; axis tight;
