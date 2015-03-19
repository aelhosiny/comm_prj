function plot_spectrum(tsq,fs)

xdft = (1/length(tsq))*fft(tsq); 
freq = -fs/2:(fs/length(tsq)):fs/2-(fs/length(tsq)); 
figure
% semilogy(freq,abs(fftshift(xdft))); grid on;


y = 20*log10(abs(fftshift(xdft)));
plot(freq, y); grid on;
xlabel('freq');
ylabel('magnitude response in dB');

end