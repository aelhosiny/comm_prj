function [] = plot_fft(amplt, r, fs)

%% Function Body
L1 = length(amplt);
NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of y
Y1 = fft(amplt',NFFT1)/L1;
f1 = fs*linspace(0,1,NFFT1);



f11 = f1(1:(length(f1))/r);
Y11 = Y1(1:(length(Y1))/r);


Y = Y11;
f = f11;

Y = abs(Y);
Y = 20*log10(Y);

figure

plot(f,Y) 
title('Spectrum - logscale')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')