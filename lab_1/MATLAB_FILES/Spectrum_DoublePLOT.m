function Spectrum_DoublePLOT(x_orig,x_fil,Fs)

%f=(-N/2+1:N/2)/N*Fs;
%X=fft(x,N);
%X_shifted=fftshift(X);
figure
subplot(2,1,1)

%plot(f,abs(X_shifted))
[pxx_orig,f]=periodogram(x_orig,[],1024,Fs,'centered');
plot(f/1000,pxx_orig,'color',[1 0.55 0.55],'LineWidth',0.8)
xlabel('Frequency (kHz)')
ylabel('Power/Frequency (1/Hz)')
title('Power Spectral Density (Linear Scale)')
hold on
[pxx_fil,f]=periodogram(x_fil,[],1024,Fs,'centered');
plot(f/1000,pxx_fil,'b','LineWidth',1.1)
legend('Original Signal','Filtered Signal')

a=axis();
a(1:2)=[-Fs/2,Fs/2]/1000;
axis(a)
grid




subplot(2,1,2)
%plot(f,20*log10(abs(X_shifted)))
plot(f/1000,10*log10(pxx_orig),'color',[1 0.55 0.55],'LineWidth',0.8)
hold on
plot(f/1000,10*log10(pxx_fil),'b','LineWidth',1.1)
legend('Original Signal','Filtered Signal')




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