function [] = upsample(gauss_smpls, upsmp_r, bitrate, osr)
%% Upsampling
gauss_smpls =  gauss_smpls.*(gauss_smpls<=2^11) + (gauss_smpls-2^12).*(gauss_smpls>2^11);

size1 = length(gauss_smpls);
% upsmp_r = 100;

gauss_smpls_up = zeros(1,(size1*upsmp_r));

for i = 1:size1
    for j = 1:upsmp_r
        gauss_smpls_up((i-1)*upsmp_r+j) = gauss_smpls(i);
    end
end

% bitrate = 2;
fs = 13 * bitrate * upsmp_r * 1000 * osr;


L1 = length(gauss_smpls_up);
NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of y
Y1 = fft(gauss_smpls_up',NFFT1)/L1;
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
title('Spectrum - logscale')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')




