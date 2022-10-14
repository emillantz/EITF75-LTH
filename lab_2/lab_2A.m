%% task 1
clc; clear; addpath('./functions/')
nbr_of_bits = 64;
data = rand(1,nbr_of_bits);


data = zeroOne(data);
stats = sum(data)
figure(2)
stem(data(1:64))
title('Transmit bits, x(n)')
%% Task 2
alpha = [0, 0.5, -0.99];
figure(3)
subplot(4, 1, 1)
stem(data)
title('transmit bits x(n)')

for i = 1:length(alpha)
recv = trim_end(conv(data, [1 alpha(i)]));
subplot(4, 1, i+1)
stem(recv)
title(sprintf('Reciever signal (α = %.2f)', alpha(i)))
end
%% Task 3
for i=1:length(alpha)
    H_z = [1, alpha(i)];
    H_t = filter(1, H_z, data);
    y_t = trim_end(conv(H_z, H_t));
    receiver_hr = trim_end(conv(data, H_z));
    y_r = filter(1, H_z, receiver_hr);

    %plot transmitter
    subplot(3, 2, 2*i - 1)
    stem(y_t)
    title(sprintf('transmitter signal, (α = %.2f)', alpha(i)))
    
    %plot receiver
    subplot(3, 2, 2*i)
    stem(y_r)
    title(sprintf('receiver signal, (α = %.2f)', alpha(i)))

    %add noise
    y_t_noisy = noise(y_t, 0.25);
    y_r_noisy = filter(1, H_z, noise(receiver_hr, 0.25));

    diff_yt = bits_diff(restructure(y_t_noisy), data);
    fprintf("Diff between restructured y_t(n) and x(n) (α = %.2f): %.3f \n", ...
        alpha(i), diff_yt)

    diff_yr = bits_diff(restructure(y_r_noisy), data);
    fprintf("Diff between restructured y_r(n) and x(n) (α = %.2f): %.3f \n\n", ...
        alpha(i), diff_yr)
count = count + diff_yr;
end