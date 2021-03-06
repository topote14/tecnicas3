% EJ_01, Moving Average filter
%
% Version: 001
% Date:    2019/11/08
% Author:  Rodrigo Gonzalez <rodralez@frm.utn.edu.ar>

clear 
close all
clc

lw = 3;

%% SIGNAL

fn = 100;       % signal frequency (Hz)
 
fs = 2000;     % sampling frequency (Hz)

dt = 1/fs;      % sampling time (s)

t = 0:dt:0.5;     % time vector (s)

signal = sin (2 * pi * fn * t); % input signal

%% NOISE

snr = 15;       % signal-noise ratio (dB)

signal_n = my_noise(signal, snr);

%% MA FILTER

N = 10;        % Moving Average filter order

a = 1;              % Denominator coefficients
b = ones(1, N) / N; % Numerator coefficients

signal_ma = filter(b, a, signal_n); % MA signal
 
%% PLOT

figure
plot(t(1:20), signal(1:20), '-b', 'linewidth', lw)
hold on
plot(t(1:20), signal_n(1:20),'--r', 'linewidth', lw)
legend('INPUT', 'NOISE')
grid on

figure
plot(t, signal, '-b', 'linewidth', lw)
hold on
plot(t, signal_n,'--r', 'linewidth', lw)
plot(t, signal_ma,'-g', 'linewidth', lw)
legend('INPUT', 'NOISE', 'MA')
grid on

figure 
freqz(b, a, 256)
grid on

%% FREQUENCY RESPONSE

[f, dft_mag,]      = my_dft(signal_n, fs);

[f_ma, dft_mag_ma] = my_dft(signal_ma, fs);

figure
plot(f, dft_mag, '--r', 'linewidth', lw)
hold on
plot(f_ma, dft_mag_ma,'-g', 'linewidth', lw)
legend('NOISE', 'MA')
grid on

