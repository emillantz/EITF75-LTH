%% Task 4
clc; clear
N = 64;
L = 3; %idfk
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

stem(yn_0)
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