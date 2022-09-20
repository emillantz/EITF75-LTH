addpath('MATLAB_FILES');

%% Task 1
%Read HQmusic.wav from file (y = signal, f = sampling freq.)
[y, f] = audioread('MATLAB_FILES/HQmusic.wav');
%Playback HQmusic.wav at reconstruction freq. f_pb (Change f_pb according
%to task)
f_pb = f * 7;
soundsc(y, f);

%% Task 2
%plot time domain signal
secs = length(y) / f;
time = linspace(0, secs, length(y));
plot(time, y)
hold on
%plot freq. domain signal
Spectrum_PLOT(y, f);

%% Task 3
filter = 1/5*ones(5,1);
%discard first 4 samples of output
u = conv(y, filter);
u = u(5:end);
Spectrum_PLOT(u, f)

%% Task 4
y_noisy = y + 0.1*randn(length(y), 1);
Spectrum_PLOT(y_noisy, f)

%% Task 5
mkiir