function Spectrum_PLOT(x,Fs)

%f=(-N/2+1:N/2)/N*Fs;
%X=fft(x,N);
%X_shifted=fftshift(X);
figure
subplot(2,1,1)

%plot(f,abs(X_shifted))
[pxx,f]=periodogram(x,[],1024,Fs,'centered');
plot(f/1000,pxx,'LineWidth',1.1)
xlabel('Frequency (kHz)')
ylabel('Power/Frequency (1/Hz)')
title('Power Spectral Density (Linear Scale)')
a=axis();
a(1:2)=[-Fs/2,Fs/2]/1000;
axis(a)
grid

subplot(2,1,2)
%plot(f,20*log10(abs(X_shifted)))
plot(f/1000,10*log10(pxx),'LineWidth',1.1)

a=axis();
a(1:2)=[-Fs/2,Fs/2]/1000;
axis(a)

xlabel('Frequency (kHz)')
ylabel('Power/Frequency (dB/Hz)')
title('Power Spectral Density (Log Scale)')
grid
%periodogram(x,[],1024,Fs,'centered')
%xlabel('Frequency (Hz)')
%ylabel('Magnitude (dB)')
%title('Magnitude Spectrum')
%grid minor

end