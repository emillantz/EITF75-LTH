%% Problem 1
zeroes = [1 0 1];
poles = [1 0 0];
%plot poles and zeroes
figure(1)
zplane(zeroes, poles)
hold on
[h, w] = freqz(zeroes, poles);
[phi, omega] = phasez(zeroes, poles);
freqz(zeroes, poles, 'half')
x1 = linspace(0, 1/2, length(h));
x2 = linspace(0, 1/2, length(phi))
figure(2)
%plot magnitude respone
subplot(2, 1, 1)
plot(w / pi, 20*log10(abs(h)))
title('Magnitude response')
ylabel('dB')
xlim([0 1/2])
%plot phase response
subplot(2, 1, 2)
plot(2 * x2, phi)
title('Phase response')
xlabel('f')
ylabel('deg')
xlim([0 1/2])

%% Problem 2
clear
zeroes = [1 0 1];
poles = [1 0 0.95^2];
%plot poles and zeroes
figure(1)
zplane(zeroes, poles)
hold on
[h, w] = freqz(zeroes, poles);
[phi, omega] = phasez(zeroes, poles);
x1 = linspace(0, 1/2, length(h));
x2 = linspace(0, 1/2, length(phi));
figure(2)
%plot magnitude respone
subplot(2, 1, 1)
plot(w / pi, 20*log10(abs(h)))
title('Magnitude response')
ylabel('dB')
xlim([0 1/2])
%plot phase response
subplot(2, 1, 2)
plot(2 * x2, phi)
title('Phase response')
xlabel('f')
ylabel('deg')
xlim([0 1/2])

%% Problem 3b
clear
D = 5;
alpha = 0.8;
b = [1, zeros(1, D), alpha];
a = zeros(1, length(b));
poles = poly(a);
figure(1)
freqz(b, poles)
[h, w] = freqz(b, poles);
figure(2)
plot(w / pi, 20*log10(abs(h)))

%% Problem 3d
clear
D = 5;
alpha = 0.8;
a = [1, zeros(1, D), alpha];
b = zeros(1, length(a));
zeroes = poly(b);
freqz(zeroes, a)