%% Task 4
clc; clear
N = 10000;
L = 6; %idfk
x_n = rand(1, N);
x_n = zeroOne(x_n);
alpha = [0 0.5 -0.99];

%inverse DFT
sf_n = ifft(x_n, N);
%CP
cp = sf_n(end - (L-2):end);
s_n = [cp, sf_n];

Hz_0 = [1 alpha(1)];
Hz_05 = [1 alpha(2)];
Hz_099 = [1 alpha(3)];

rn_0 = conv(s_n, Hz_0);
rn_05 = conv(s_n, Hz_05);
rn_099 = conv(s_n, Hz_099);

rfn_0 = rn_0(L:end-(L-1));
rfn_05 = rn_05(L:end-(L-1));
rfn_099 = rn_099(L:end-(L-1));

yn_0 = fft(rfn_0, N);
yn_05 = fft(rfn_05, N);
yn_099 = fft(rfn_099, N);

%diff_0 = diff(x_n, sign(real(yn_0)))
%diff_05 = diff(x_n, sign(real(yn_05)))
%diff_099 = diff(x_n, sign(real(yn_099)))

%y(n) / H(k) = x(n)
hn_0 = [1, alpha(1), zeros(1, 62)];
hn_05 = [1, alpha(2), zeros(1, 62)];
hn_099 = [1, alpha(3), zeros(1, 62)];

Hk_0 = fft(hn_0, N);
Hk_05 = fft(hn_05, N);
Hk_099 = fft(hn_099, N);

xn_fig4_0 = yn_0 ./ Hk_0;
xn_fig4_05 = yn_05 ./ Hk_05;
xn_fig4_099 = yn_099 ./ Hk_099;

x_n_vs_xn_fig_4_0 = diff(sign(real(xn_fig4_0)), x_n)
x_n_vs_xn_fig_4_05 = diff(sign(real(xn_fig4_05)), x_n)
x_n_vs_xn_fig_4_099 = diff(sign(real(xn_fig4_099)), x_n)

%% Task 5

% 1 & 2 verified in task 4
rn_0_noise = noise(rn_0);
rn_05_noise = noise(rn_05);
rn_099_noise = noise(rn_099);

rn_0_restruct = sign(real(rn_0_noise));
rn_05_restruct = sign(real(rn_05_noise));
rn_099_restruct = sign(real(rn_099_noise));

rn_0_nocp = rn_0_restruct(L:end-(L-1));
rn_05_nocp = rn_05_restruct(L:end-(L-1));
rn_099_nocp = rn_099_restruct(L:end-(L-1));

yn_0_noise = fft(rn_0_nocp, N);
yn_05_noise = fft(rn_05_nocp, N);
yn_099_noise = fft(rn_099_nocp, N);

xn_0_noise = yn_0_noise ./ Hk_0;
xn_05_noise = yn_05_noise ./ Hk_05;
xn_099_noise = yn_099_noise ./ Hk_099;

diff(sign(real(xn_0_noise)), x_n)
diff(sign(real(xn_05_noise)), x_n)
diff(sign(real(xn_099_noise)), x_n)
%% Functions
function fixed = zeroOne(Vector)
Vector = Vector < 0.5;
Inverterare = Vector -1;
fixed = Vector + Inverterare;
end

function back = restructure(Vector)
back = sign(real(Vector));
end

function diff = diff(Vector1, Vector2)
diff = sum(Vector1~=Vector2);
end

function noised = noise(Vector)
noised = sqrt(0.25/64)*randn(1,length(Vector)) + Vector;
end

function trimmed = trim(Vector)
trimmed = Vector(1:end-1);
end