% Example 5.10 – Cascaded FIR LP + HP -> Band-pass
clear; clc;

fs   = 22050;            % Hz
N    = 20;               % filter order
L    = N + 1;            % number of taps
hwin = hamming(L);       % Hamming window

% ----- Low-pass: fc = 5.5 kHz -----
fc_lp = 5500;                           % Hz
Wn_lp = fc_lp / (fs/2);                 % normalized
b_lp  = fir1(N, Wn_lp, 'low',  hwin);   % LP FIR

% ----- High-pass: fc = 3.0 kHz -----
fc_hp = 3000;                           % Hz
Wn_hp = fc_hp / (fs/2);                 % normalized
b_hp  = fir1(N, Wn_hp, 'high', hwin);   % HP FIR

% ----- Cascade (band-pass) -----
b_bp = conv(b_lp, b_hp);                % cascade two FIRs

% ----- Frequency responses -----
nfft = 4096;
[Hlp, f]  = freqz(b_lp, 1, nfft, fs);
[Hhp, ~]  = freqz(b_hp, 1, nfft, fs);
[Hbp, ~]  = freqz(b_bp, 1, nfft, fs);

% ----- Plots (magnitudes) -----
figure(1); clf;

subplot(3,1,1);
plot(f, abs(Hlp), 'LineWidth', 1); grid on;
title(sprintf('Low-pass FIR (N=%d, fc=%d Hz, Hamming)', N, fc_lp));
xlabel('Frequency (Hz)'); ylabel('Gain'); axis([0 fs/2 0 1.2]);

subplot(3,1,2);
plot(f, abs(Hhp), 'LineWidth', 1); grid on;
title(sprintf('High-pass FIR (N=%d, fc=%d Hz, Hamming)', N, fc_hp));
xlabel('Frequency (Hz)'); ylabel('Gain'); axis([0 fs/2 0 1.2]);

subplot(3,1,3);
plot(f, abs(Hbp), 'LineWidth', 1); grid on;
title('Cascaded Magnitude (Band-pass = LP * HP)');
xlabel('Frequency (Hz)'); ylabel('Gain'); axis([0 fs/2 0 1.2]);

% (Optional) mark the specified edges
% xline(fc_hp, '--k', '3 kHz'); xline(fc_lp, '--k', '5.5 kHz');
