function noised = noise(Vector, sigma_squared)
noised = sqrt(sigma_squared)*randn(1,length(Vector)) + Vector;
end