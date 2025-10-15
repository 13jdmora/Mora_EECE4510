% Problem 5.23  p. 280 Blandford  
%               p. 719 Blandford (appendix)
% EECE 4510 / 5510 - Marquette University
% Fred J. Frigo, Ph.D.
% October 9, 2023
%

fs = 44100;
fpass = 8000;
Rp = 0.01;
fstop = 10000;
Rs = .02;

%Parks-McClelland
F = ([fpass fstop]);
M = ([1 0]);
Dev = [Rp Rs];
[N F A W] = firpmord(F, M, Dev, fs);
disp(N);
N = 40;
num_pm = firpm(N, F, A, W);
[H f] = freqz(num_pm, 1, 1024, fs);

%Kaiser
fc = fpass + (fstop-fpass)/2;
eps = min(Rp, Rs);
A = -20*log10(eps);
Ka = (A - 7.95)/14.36;
alpha = 0.1102*(A - 8.7);
L = ceil(1 + Ka*fs/(fstop - fpass));
disp(L-1);
L = 52;
num_kaiser = fir1(L-1, fc/(fs/2), kaiser(L, alpha));
[H f] = freqz(num_kaiser, 1, 1024, fs);

% -------------------- Magnitude and Phase Plots --------------------
figure(1); clf;

subplot(2,1,1);
plot(f, abs(H_pm), 'b', 'LineWidth', 1.0); hold on;
plot(f, abs(H_kaiser), 'r', 'LineWidth', 1.0);
axis([0 fs/2 0 1.2]);
title('Low-pass FIR Filters: Parks-McClellan vs Kaiser Window');
xlabel('Frequency (Hz)');
ylabel('Gain');
legend(sprintf('Parks-McClellan (N=%d)', N), ...
       sprintf('Kaiser Window (N=%d)', L-1), ...
       'Location','SouthWest');
grid on;

subplot(2,1,2);
plot(f, unwrap(angle(H_pm))*180/pi, 'b', 'LineWidth', 1.0); hold on;
plot(f, unwrap(angle(H_kaiser))*180/pi, 'r', 'LineWidth', 1.0);
axis([0 fs/2 -180 180]);
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
title('Phase Response');
legend('Parks-McClellan','Kaiser','Location','SouthWest');
grid on;

% -------------------- Optional Zooms --------------------
figure(2); clf;

subplot(3,1,1); % Passband zoom
plot(f, abs(H_pm), 'b'); hold on;
plot(f, abs(H_kaiser), 'r');
axis([0 fpass 1-Rp 1+Rp]);
title('Passband Zoom');
xlabel('Frequency (Hz)'); ylabel('Gain'); grid on;

subplot(3,1,2); % Transition band
plot(f, abs(H_pm), 'b'); hold on;
plot(f, abs(H_kaiser), 'r');
axis([fpass fstop 0 1]); grid on;
title('Transition Band');
xlabel('Frequency (Hz)');

subplot(3,1,3); % Stopband zoom
plot(f, abs(H_pm), 'b'); hold on;
plot(f, abs(H_kaiser), 'r');
axis([fstop fs/2 0 Rs]);
title('Stopband Zoom');
xlabel('Frequency (Hz)'); ylabel('Gain'); grid on;