% prob_8_edge_enhancement.m  - Edge enhancement on MR brain image
% Image file: e31s360i11.dcm
% By Jose Mora

clear; close all; clc;

%% A) Read and display original DICOM grayscale image
fname = 'e31s360i11.dcm';          % make sure this file is in the path
I = dicomread(fname);
I = double(I);                     % convert to double for processing
I = I / max(I(:));                 % normalize to [0,1]

figure;
subplot(1,3,1);
imshow(I, []);
title('A) Original DICOM image');

%% B) Edge-enhanced image using Sobel filtering
% Sobel kernels in x and y
Sx = fspecial('sobel');
Sy = Sx';

Ix = imfilter(I, Sx, 'replicate');
Iy = imfilter(I, Sy, 'replicate');

Gmag = sqrt(Ix.^2 + Iy.^2);        % gradient magnitude (edge strength)
Gmag = Gmag / max(Gmag(:));        % normalize for display

subplot(1,3,2);
imshow(Gmag, []);
title('B) Sobel gradient magnitude');

%% C) Edge-enhanced image using MATLAB edge() function
% (here we use the Canny detector; default is also fine)
E = edge(I, 'canny');              % binary edge map

subplot(1,3,3);
imshow(E, []);
title('C) edge(I, ''canny'') result');
