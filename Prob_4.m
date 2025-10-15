% Problem 5.12 – Window impulse responses for length 30
% Rectangular, Triangular, Hamming, von Hann, Blackman
clear; clc;

N  = 30;                % window length
n  = 0:N-1;             % sample index

w_rect = rectwin(N);    % rectangular
w_tri  = triang(N);     % triangular
w_ham  = hamming(N);    % Hamming
w_hann = hann(N);       % von Hann (a.k.a. Hann)
w_black= blackman(N);   % Blackman

% Plot as “impulse responses” (stem plots)
figure(1); clf;
tiledlayout(5,1,'Padding','compact','TileSpacing','compact');

nexttile;
stem(n, w_rect, 'filled'); grid on;
title('Rectangular window (N = 30)');
xlabel('n'); ylabel('w[n]'); ylim([0 1.1]);

nexttile;
stem(n, w_tri, 'filled'); grid on;
title('Triangular window (N = 30)');
xlabel('n'); ylabel('w[n]'); ylim([0 1.1]);

nexttile;
stem(n, w_ham, 'filled'); grid on;
title('Hamming window (N = 30)');
xlabel('n'); ylabel('w[n]'); ylim([0 1.1]);

nexttile;
stem(n, w_hann, 'filled'); grid on;
title('von Hann (Hann) window (N = 30)');
xlabel('n'); ylabel('w[n]'); ylim([0 1.1]);

nexttile;
stem(n, w_black, 'filled'); grid on;
title('Blackman window (N = 30)');
xlabel('n'); ylabel('w[n]'); ylim([0 1.1]);
