function [] = ideal_intrp(gauss_smpls, bitrate, osr)

%% Function Body

% Unsigned to signed converion
gauss_smpls =  gauss_smpls.*(gauss_smpls<=2^11) + (gauss_smpls-2^12).*(gauss_smpls>2^11);
% Interpolate samples
% Calculate FFT


fs = 13 * bitrate * 1000 * osr;


L1 = length(gauss_smpls_idl);
NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of y
Y1 = fft(gauss_smpls_idl',NFFT1)/L1;
f1 = fs*linspace(0,1,NFFT1);

r = 10;

f11 = f1(1:(length(f1))/r);
Y11 = Y1(1:(length(Y1))/r);


Y = Y11;
f = f11;

Y = abs(Y);
Y = 20*log10(Y);

figure

plot(f,Y) 
title('Spectrum before interpolation - logscale')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')