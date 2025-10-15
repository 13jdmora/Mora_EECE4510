% Elliptic low-pass per spec
% fs = 44,100 Hz
% passband: 0–4500 Hz with 1% passband ripple
% stopband: 6000 Hz–fs/2 with <= 3% stopband amplitude (~ -30.46 dB)

fs   = 44100;
fs2  = fs/2;

fpass = 4500;                  % Hz
fstop = 6000;                  % Hz

% Spec as amplitude ripples:
Rp   = 0.01;                   % passband ripple (<= 1 of unity)  -> 1%
Rs   = 0.03;                   % stopband amplitude (<= 0.03)     -> 3%

% Convert to dB for ellipord/ellip
RpDB = -20*log10(1 - Rp);      % ≈ 0.087 dB
RsDB = -20*log10(Rs);          % ≈ 30.46 dB

% Minimum order elliptic design
[N, Wp]  = ellipord(fpass/fs2, fstop/fs2, RpDB, RsDB);
[num, den] = ellip(N, RpDB, RsDB, Wp, 'low');

fprintf('Elliptic low-pass order N = %d, Wp(norm) = %.6f\n', N, Wp);

% Frequency response
[H, f] = freqz(num, den, 1024, fs);

% Plots (same layout as your Butterworth example)
figure(1); clf;

subplot(2,1,1);
plot(f, abs(H));
title('Low-pass Elliptic (Cauer) filter');
axis([0 fs/2 0 1.2]);
xlabel('frequency in Hertz');
ylabel('gain');

subplot(2,1,2);
plot(f, 180*angle(H)/pi);
axis([0 fs/2 -180 180]);
xlabel('frequency in Hertz');
ylabel('Phase in degrees');
