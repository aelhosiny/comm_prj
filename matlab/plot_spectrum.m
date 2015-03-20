function plot_spectrum(tsq,fs)

L = length (tsq); % Window Length of FFT    
nfft = 2^nextpow2(L); % Transform length

y_HannWnd = tsq.*hanning(L);            
xdft = fft(y_HannWnd,nfft)/L;
freq = fs/2*linspace(-1,1,nfft/2+1); 
freq = -fs/2:(fs/nfft):fs/2-(fs/nfft); 

% xdft = (1/length(tsq))*fft(tsq); 
% freq = -fs/2:(fs/length(tsq)):fs/2-(fs/length(tsq)); 
figure
% semilogy(freq,abs(fftshift(xdft))); grid on;


y = 20*log10(abs(fftshift(xdft)));
plot(freq, y); grid on;
xlabel('freq');
ylabel('magnitude response in dB');

end