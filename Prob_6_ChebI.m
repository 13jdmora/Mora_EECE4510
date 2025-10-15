% Example 6_4 (Chebyshev I version) - Blandford p297 style
% fs = 44,100 Hz
% passband: 0–4500 Hz with 1% ripple
% stopband: 6000 Hz–fs/2 with <= 3% amplitude (≈ -30.46 dB)

fs   = 44100;
fs2  = fs/2;

fpass = 4500;    % Hz
fstop = 6000;    % Hz

Rp   = 0.01;                     % passband ripple (amplitude)
Rs   = 0.03;                     % stopband amplitude (<= 0.03)

% Convert amplitude specs to dB for cheb1ord/cheby1
RpDB = -20*log10(1 - Rp);        % ≈ 0.087 dB
RsDB = -20*log10(Rs);            % ≈ 30.46 dB

% Minimum order Chebyshev Type-I low-pass
[N, Wp] = cheb1ord(fpass/fs2, fstop/fs2, RpDB, RsDB);
[num, den] = cheby1(N, RpDB, Wp, 'low');

% Frequency response
[H, f] = freqz(num, den, 1024, fs);

fprintf('Chebyshev Type-I order N = %d, Wp(norm) = %.6f\n', N, Wp);

% Plots (same layout as your Butterworth example)
figure(1); clf;
subplot(2,1,1);
plot(f, abs(H));
title('Low-pass Chebyshev Type-I filter');
axis([0 fs/2 0 1.2]);
xlabel('frequency in Hertz');
ylabel('gain');

subplot(2,1,2);
plot(f, 180*angle(H)/pi);
axis([0 fs/2 -180 180]);
xlabel('frequency in Hertz');
ylabel('Phase in degrees');
