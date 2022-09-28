addpath('MATLAB_FILES/');

%% Task 6
[y1, f1] = audioread('MATLAB_FILES/HQmusic.wav');
secs = length(y1) / f1;
time = linspace(0, secs, length(y1));
f_dist = f1 / 4;
dist = (0.1 * sin(2*pi * f_dist .* time))';

y1 = y1 + dist;

plot(time * f_dist, y1)
soundsc(y1, f1)
Spectrum_PLOT(y1, f1)
%% Task 7
load('new_filter.mat');
y1_f = filter(b, a, y1);
Spectrum_PLOT(y1_f, f1)
soundsc(y1_f, f1)

%% Task 8
[y2, f2] = audioread('MATLAB_FILES/distorted_music/lovesong.wav');
%soundsc(y2, f2)
Spectrum_PLOT(y2, f2)
%signal spikes at ±0.12kHz, ±1.04kHz, ±1.78kHz and ±3kHz
zeroes = 1.0e+3*[-0.12, 0.12, -1.04, 1.04, -1.78, 1.78, -3, 3] / f2;
zeroes = zeroes * (2 *  pi);
zeroes = exp(i * zeroes);
%as many poles as zeroes
poles = 0 * ones(1, length(zeroes));
b = poly(zeroes);
a = poly(poles);
y2_f = filter(b, a, y2);
Spectrum_PLOT(y2_f, f2);
soundsc(y2_f, f2)
Spectrum_DoublePLOT(y2, y2_f, f2)
%% Task 9
[y2, f2] = audioread('MATLAB_FILES/distorted_music/lovesong.wav');
%soundsc(y2, f2)
Spectrum_PLOT(y2, f2)
%signal spikes at ±0.12kHz, ±1.04kHz, ±1.78kHz and ±3kHz
zeroes = 1.0e+3*[-0.12, 0.12, -1.04, 1.04, -1.78, 1.78, -3, 3] / f2;
zeroes = zeroes * (2 * pi);
zeroes = exp(i * zeroes);
%IIR notch, poles near zeroes
poles = 0.95 * zeroes;
b = poly(zeroes);
a = poly(poles);
y2_f = filter(b, a, y2);
Spectrum_PLOT(y2_f, f2);
soundsc(y2_f, f2)
Spectrum_DoublePLOT(y2, y2_f, f2)
%% Task 10
% Create echo
[y,f] = audioread('MATLAB_FILES/speech1.wav');
%soundsc(y, f)
delay = 50 / 340;
alpha = 0.8;
D = delay * f;
D = round(D);
b = [1, zeros(1, D), alpha];
poles = 0*ones(1, length(b));
a = poly(poles);
u = filter(b, a, y);
%create time vector
time = length(y) / f;
time = linspace(0, time, length(y));

%plot original signal (time domain)
%subplot(2, 1, 1)
%plot(time * f, y)
%plot echoed signal (time domain)
%subplot(2, 1, 2)
%plot(time * f, u)
%plot echoed signal (freq. domain)
Spectrum_PLOT(u, f)
%soundsc(u, f)

%% Task 11
%create time vector
time = length(y) / f;
time = linspace(0, time, length(y));

% Remove echo by inverse filtering
a_new = [1, zeros(1, D), alpha];
b_new = 0*ones(1, length(a_new));
b_new = poly(b_new);
x = filter(b_new, a_new, u);
subplot(2, 2, 1, 'replace')
plot(time * f, y)
subplot(2, 2, 3:4)
plot(time * f, u)
subplot(2, 2, 2)
plot(time * f, x)
soundsc(x, f)
Spectrum_PLOT(x, f)
