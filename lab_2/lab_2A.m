%% task 1
clc; clear
nbr_of_bits = 50000;
data = rand(1,nbr_of_bits);
data = zeroOne(data);
figure(1)
stem(data(1:64))
%% task 2
alpha = [0 0.5 -0.99];

reciever_0 = trim(conv(data,[1 alpha(1)]));
reciever_05 = trim(conv(data,[1 alpha(2)]));
reciever_099 = trim(conv(data,[1 alpha(3)]));
figure(2);
subplot(4,1,1)
stem(data(1:64))
subplot(4,1,2)
stem(reciever_0(1:64))
subplot(4,1,3)
stem(reciever_05(1:64))
subplot(4,1,4)
stem(reciever_099(1:64))
reciever_0 = noise(reciever_0);
reciever_05 = noise(reciever_05);
reciever_099 = noise(reciever_099);
reciever_0_recon = restructure(reciever_0);
reciever_05_recon = restructure(reciever_05);
reciever_099_recon = restructure(reciever_099);
diff_alpha0 = diff(reciever_0_recon,data)
diff_alpha05 = diff(reciever_05_recon,data)
diff_alpha099 = diff(reciever_099_recon,data)
%% Task 3

Hz_0 = [1 alpha(1)];
Hz_05 = [1 alpha(2)];
Hz_099 = [1 alpha(3)];

% H_t(z)
H_t0 = filter(1, Hz_0, data);
H_t05 = filter(1, Hz_05, data);
H_t099 = filter(1, Hz_099, data);
y_t0 = trim(conv(Hz_0, H_t0));
y_t05 = trim(conv(Hz_05, H_t05));
y_t099 = trim(conv(Hz_099, H_t099));

% H_r(z)
reciever_hr0 = trim(conv(data, Hz_0));
reciever_hr05 = trim(conv(data, Hz_05));
reciever_hr099 = trim(conv(data, Hz_099));

y_r0 = filter(1, Hz_0, reciever_hr0);
y_r05 = filter(1, Hz_05, reciever_hr05);
y_r099 = filter(1, Hz_099, reciever_hr099);

% plots
% transmitter
figure(3)
subplot(3, 2, 1)
stem(y_t0(1:64))
title('transmitter signal (α = 0)')
subplot(3, 2, 3)
stem(y_t05(1:64))
title('transmitter signal (α = 0.5)')
subplot(3, 2, 5)
stem(y_t099(1:64))
title('transmitter signal (α = -0.99)')
% receiver
subplot(3, 2, 2)
stem(y_r0(1:64))
title('reciever signal (α = 0)')
subplot(3, 2, 4)
stem(y_r05(1:64)) 
title('reciever signal (α = 0.5)')
subplot(3, 2, 6)
stem(y_r099(1:64))
title('reciever signal (α = -0.99)')

% add noise
y_t0_noisy = noise(y_t0);
y_t05_noisy = noise(y_t05);
y_t099_noisy = noise(y_t099);

y_r0_noisy = filter(1, Hz_0, noise(reciever_hr0));
y_r05_noisy = filter(1, Hz_05, noise(reciever_hr05));
y_r099_noisy = filter(1, Hz_099, noise(reciever_hr099));

% diff noisy functions
diff_t0 = diff(data, restructure(y_t0_noisy))
diff_r0 = diff(data, restructure(y_r0_noisy))

diff_t05 = diff(data, restructure(y_t05_noisy))
diff_r05 = diff(data, restructure(y_r05_noisy))

diff_t099 = diff(data, restructure(y_t099_noisy))
diff_r099 = diff(y_r099, restructure(y_r099_noisy))
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

function noised = noise(Vector)
noised = 0.5*randn(1,length(Vector)) + Vector;
end

function trimmed = trim(Vector)
trimmed = Vector(1:end-1);
end