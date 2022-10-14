%% Task 4
clc; clear; addpath('./functions/')
N = 64;
L = 6; %idfk
x_n = rand(1, N);
x_n = zeroOne(x_n);
alpha = [0 0.5 -0.99];
%inverse DFT
sf_n = ifft(x_n, N);
%CP
cp = sf_n(end - (L-2):end);
s_n = [cp, sf_n];

for i=1:length(alpha)
    H_z = [1, alpha(i)];

    r_n = conv(s_n, H_z);
    rf_n = r_n(L:end-(L-1));
    y_n = fft(rf_n, N);
    h_n = [1, alpha(i), zeros(1, 62)];

    H_k = fft(h_n, N);
    xn_fig4 = y_n ./ H_k;
    error = bits_diff(sign(real(xn_fig4)), x_n);

    fprintf("Difference between Re(x(n)) using model " + ...
        "from figure 3, and x(n) (α = %.2f): %.3f \n\n", alpha(i), error);
end

%% Task 5
% THIS IS PROBABLY NOT RIGHT HANDLE WITH CARE
for i=1:length(alpha)
    H_z = [1, alpha(i)];

    r_n = conv(s_n, H_z);
    rf_n = r_n(L:end-(L-1));
    y_n = fft(rf_n, N);

    H_k = fft(H_z, N);

    rn_noise = noise(r_n, 0.5/64);
    rn_restruct = sign(real(rn_noise));
    rf_n = rn_restruct(L:end-(L-1));
    
    yn_noise = fft(rf_n, N);
    xn_noise = yn_noise ./ H_k;

    error = bits_diff(sign(real(xn_noise)), x_n);
    fprintf("Difference between Re(x(n)) using model " + ...
        "from figure 4, and x(n) (α = %.2f): %.3f \n\n", alpha(i), error);

end