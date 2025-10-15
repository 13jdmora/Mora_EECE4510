% Problem: Create a 20 ms, 500 Hz sinewave @ 48 kHz and resample to 44.1 kHz
% Plot both original and resampled waveforms
%
% Jose / MU
clear; clc; close all;

%% A) Generate 20 ms 500 Hz sinewave at 48 kHz
fs_orig = 48000;                 % Original sample rate
f = 500;                         % Frequency (Hz)
duration = 0.020;                % 20 milliseconds
t = 0:1/fs_orig:duration;        % time vector
x = sin(2*pi*f*t);               % 500 Hz sinewave

%% Resample to 44.1 kHz
fs_new = 44100;
y = resample(x, fs_new, fs_orig);    % MATLAB built-in resampling
t_new = (0:length(y)-1)/fs_new;      % new time vector

%% B) Plot both signals
figure(1); clf;

subplot(2,1,1);
plot(t*1000, x, 'b'); grid on;
title('Original 500 Hz Sinewave (48 kHz, 20 ms)');
xlabel('Time (ms)'); ylabel('Amplitude');
xlim([0 20]);

subplot(2,1,2);
plot(t_new*1000, y, 'r'); grid on;
title('Resampled Sinewave (44.1 kHz)');
xlabel('Time (ms)'); ylabel('Amplitude');
xlim([0 20]);

% Optional: Overlay for direct visual comparison
figure(2); clf;
plot(t*1000, x, 'b', 'LineWidth', 1); hold on;
plot(t_new*1000, y, 'r--', 'LineWidth', 1);
grid on;
title('Overlay: Original vs Resampled (20 ms segment)');
xlabel('Time (ms)'); ylabel('Amplitude');
legend('Original (48 kHz)', 'Resampled (44.1 kHz)');
xlim([0 20]);
