%% Problem 1
zeroes = [1 0 1];
poles = [1 0 0];
%plot poles and zeroes
figure(1)
zplane(zeroes, poles)
hold on
[h, w] = freqz(zeroes, poles);
[phi, omega] = phasez(zeroes, poles);
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

%% Problem 3
clear
% b
