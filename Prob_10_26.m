% prob10_26.m  - Blandford & Parr 10.26
% 2-D ideal low-pass filter with normalized cutoff 0.35
% Apply a von Hann window and display the results.
% By Jose Mora

clear; close all; clc;

%% Filter size and cutoff
N  = 51;        % odd size so filter is centered (51 x 51)
fc = 0.35;      % normalized cutoff frequency (0..1, where 1 = Nyquist)

% 1-D index (spatial) for building the impulse response
n = -(N-1)/2 : (N-1)/2;

%% 1-D ideal low-pass impulse response (sinc)
% h1[n] = fc * sinc(fc * n), using MATLAB's sinc(x)=sin(pi*x)/(pi*x)
h1 = fc * sinc(fc * n);

%% 2-D ideal low-pass filter (separable: outer product)
h2_ideal = h1.' * h1;    % size N x N

%% 2-D von Hann window
w1   = hann(N);          % 1-D Hann (von Hann) window
W2   = w1 * w1.';        % 2-D Hann window (outer product)

%% Windowed 2-D low-pass filter
h2_win = h2_ideal .* W2;

%% Display results
figure;

subplot(2,2,1);
mesh(h2_ideal);
title('Ideal 2-D low-pass impulse response');
xlabel('x'); ylabel('y'); zlabel('h(x,y)');

subplot(2,2,2);
mesh(h2_win);
title('Windowed 2-D low-pass (von Hann)');
xlabel('x'); ylabel('y'); zlabel('h_w(x,y)');

subplot(2,2,3);
imagesc(h2_ideal); axis image; colorbar;
title('Ideal 2-D LP (magnitude, image view)');

subplot(2,2,4);
imagesc(h2_win); axis image; colorbar;
title('Windowed 2-D LP (magnitude, image view)');
colormap jet;
