% Inverted Chebyshev (Type-II) low-pass per spec
% fs = 44,100 Hz
% passband: 0–4500 Hz with 1% passband ripple
% stopband: 6000 Hz–fs/2 with <= 3% amplitude (≈ -30.46 dB)

fs   = 44100;
fs2  = fs/2;

fpass = 4500;                  % Hz
fstop = 6000;                  % Hz

Rp   = 0.01;                   % passband ripple (amplitude) <= 1%
Rs   = 0.03;                   % stopband amplitude (<= 3%)

% Convert amplitude specs to dB for cheb2ord / cheby2
RpDB = -20*log10(1 - Rp);      % ≈ 0.087 dB
RsDB = -20*log10(Rs);          % ≈ 30.46 dB

% Minimum-order Chebyshev Type-II design
[Ny, Wst] = cheb2ord(fpass/fs2, fstop/fs2, RpDB, RsDB);
[num, den] = cheby2(Ny, RsDB, Wst, 'low');

% Report order and normalized stopband edge used
fprintf('Chebyshev Type-II order N = %d, Wst(norm) = %.6f\n', Ny, Wst);

% Frequency response
[H, f] = freqz(num, den, 1024, fs);

% Plots (same layout as your Butterworth example)
figure(1); clf;

subplot(2,1,1);
plot(f, abs(H));
title('Low-pass Chebyshev Type-II (Inverted Chebyshev)');
axis([0 fs/2 0 1.2]);
xlabel('frequency in Hertz');
ylabel('gain');

subplot(2,1,2);
plot(f, 180*angle(H)/pi);
axis([0 fs/2 -180 180]);
xlabel('frequency in Hertz');
ylabel('Phase in degrees');
