function [B, A] = boost(gain, fc, bw, fs)
%BOOST  Design a peaking (parametric) EQ section.
%   [B,A] = BOOST(gain, fc, bw, fs)
%   gain : linear peak gain (e.g., 4)
%   fc   : center frequency in Hz
%   bw   : bandwidth in Hz
%   fs   : sampling rate in Hz

    Q   = fs / bw;        % quality factor
    wcT = 2*pi*fc/fs;     % normalized radian frequency
    K   = tan(wcT/2);
    V   = gain;

    b0 =  1 + V*K/Q + K^2;
    b1 =  2*(K^2 - 1);
    b2 =  1 - V*K/Q + K^2;

    a0 =  1 + K/Q + K^2;
    a1 =  2*(K^2 - 1);
    a2 =  1 - K/Q + K^2;

    A  = [a0 a1 a2] / a0;
    B  = [b0 b1 b2] / a0;
end
