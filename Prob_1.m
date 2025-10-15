%% Problem 1 – MATLAB Fourier Transform – interpolation
% A) Read color image from URL
% B) Convert to grayscale, display & report resolution
% C) FFT magnitude display
% D) Zero-fill FFT for 2× interpolation, display & report new resolution
clear; clc; close all;

url = 'https://bloomcounty.eng.mu.edu/fred/Waterloo.jpg';

% Attempt to read from URL, otherwise download locally first
try
    rgb = imread(url);
catch
    tmpfile = fullfile(tempdir, 'Waterloo.jpg');
    websave(tmpfile, url);
    rgb = imread(tmpfile);
end

%% B) Convert to grayscale
if size(rgb,3) == 3
    gray = rgb2gray(rgb);
else
    gray = rgb;
end

[M, N] = size(gray);

% --- Display color and grayscale with resolution info ---
figure(1); clf;
subplot(1,2,1);
imshow(rgb);
title(sprintf('A) Original color image (Resolution: %d×%d)', size(rgb,1), size(rgb,2)));

subplot(1,2,2);
imshow(gray);
title(sprintf('B) Grayscale image (Resolution: %d×%d)', M, N));

%% C) 2D FFT magnitude (log scale)
F = fftshift(fft2(double(gray)));
magF = log(1 + abs(F));

figure(2); clf;
imagesc(magF); axis image off; colormap gray; colorbar;
title('C) Magnitude of FFT (log scale, centered)');

%% D) Zero-fill FFT to expand by factor of 2
padM = 2 * M;
padN = 2 * N;
Fpad = zeros(padM, padN);
r0 = floor((padM - M)/2);
c0 = floor((padN - N)/2);
Fpad((1:M)+r0, (1:N)+c0) = F;

interp = real(ifft2(ifftshift(Fpad))) * (padM*padN)/(M*N);

figure(3); clf;
subplot(1,2,1);
imshow(gray);
title(sprintf('Original Grayscale (Resolution: %d×%d)', M, N));

subplot(1,2,2);
imshow(uint8(interp));
title(sprintf('D) Interpolated (Zero-filled 2× FFT) (Resolution: %d×%d)', padM, padN));
