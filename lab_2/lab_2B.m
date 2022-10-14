%% Task 4
clc; clear; addpath('./functions/')
N = 64;
L = 2;
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
    h_n = [1, alpha(i)];

    H_k = fft(h_n, N);
    xn_fig4 = y_n ./ H_k;
    error = bits_diff(sign(real(xn_fig4)), x_n);

    fprintf("Difference between Re(x(n)) using model " + ...
        "from figure 3, and x(n) (α = %.2f): %.3f \n\n", alpha(i), error);
end

%% Task 5
for i=1:length(alpha)
    H_z = [1, alpha(i)];

    r_n = conv(s_n, H_z);
    rn_noise = noise(r_n, 0.25/64);

    rf_n = rn_noise(L:end-(L-1));
    y_n = fft(rf_n, N);
    
    h_n = [1, alpha(i), zeros(1, N-2)];
    H_k = fft(h_n, N);

    xn_noise = y_n ./ H_k;

    error = bits_diff(sign(real(xn_noise)), x_n);
    count = count + error;
    fprintf("Difference between Re(x(n)) using model " + ...
         "from figure 4, and x(n) (α = %.2f): %.3f \n\n", alpha(i), error);

end