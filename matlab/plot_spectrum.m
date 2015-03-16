function plot_spectrum(tsq,fs)

xdft = (1/length(tsq))*fft(tsq); 
freq = -fs/2:(fs/length(tsq)):fs/2-(fs/length(tsq)); 
figure
plot(freq,abs(fftshift(xdft))); grid on;

end