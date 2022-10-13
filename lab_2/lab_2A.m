%% task 1
clc; clear
nbr_of_bits = 64;
data = rand(1,nbr_of_bits);


data = zeroOne(data);
stats = sum(data)
figure(2)
stem(data(1:64))
title('Transmit bits, x(n)')
%% Task 2
alpha = [0, 0.5, 0.99];
figure(3)
subplot(4, 1, 1)
stem(data)
title('transmit bits x(n)')

for i = 1:length(alpha)
recv = trim(conv(data, [1 alpha(i)]));
subplot(4, 1, i+1)
stem(recv)
title(sprintf('Reciever signal (α = %.2f)', alpha(i)))
end
%% Alternate task 3

for i=1:length(alpha)
    H_z = [1, alpha(i)];
    H_t = filter(1, H_z, data);
    y_t = trim(conv(H_z, H_t));
    receiver_hr = trim(conv(data, H_z));
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

    diff_yt = diff(restructure(y_t_noisy), data);
    fprintf("Diff between restructured y(t) and x(n) (α = %.2f): %.3f \n", ...
        alpha(i), diff_yt)

    diff_yr = diff(restructure(y_r_noisy), data);
    fprintf("Diff between restructured y(r) and x(n) (α = %.2f): %.3f \n", ...
        alpha(i), diff_yr)
    fprintf("\n")
end
%% Functions
function fixed = zeroOne(Vector)
Vector = Vector < 0.5;
Inverterare = Vector -1;
fixed = Vector + Inverterare;
end

function back = restructure(Vector)
back = Vector > 0;
Inverterare = back -1;
back = back + Inverterare;
end

function diff = diff(Vector1, Vector2)
diff = sum(Vector1~=Vector2);
end

function noised = noise(Vector, sigma_squared)
noised = sqrt(sigma_squared)*randn(1,length(Vector)) + Vector;
end

function trimmed = trim(Vector)
trimmed = Vector(1:end-1);
end