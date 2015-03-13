clear all; close all; clc;

%gauss_smpls = dlmread('fltr_out.txt');
%intrp_smpls = dlmread('intrp_out.txt');

% remal_test_43_31119_RTL 20 
% remal_test_44_10553_RTL 25
% remal_test_45_5699_RTL  40 
% remal_test_46_7851_RTL  50
% remal_test_47_30560_RTL 100

% remal_test_48_16958_RTL 8 
% remal_test_49_31408_RTL 10
% remal_test_50_6641_RTL  16
% remal_test_51_5952_RTL  20
% remal_test_52_2288_RTL  25

% remal_test_53_4351_RTL
% remal_test_54_3624_RTL
% remal_test_55_25562_RTL
% remal_test_56_21447_RTL
% remal_test_57_32025_RTL

% remal_test_58_29_RTL
% remal_test_59_3555_RTL
% remal_test_60_7869_RTL
% remal_test_61_14379_RTL
% remal_test_62_28516_RTL

% remal_test_63_28797_RTL 2
% remal_test_64_19833_RTL 4
% remal_test_65_26539_RTL 5 
% remal_test_66_30998_RTL 10

% remal_test_67_22409_RTL 2
% remal_test_68_2069_RTL  4


% passed/remal_test_55_8621_RTL

% /net/tiger/scratch/aelhosiny/projects/remal/sim/adhoc/interpolator/test_44/simout/


gauss_smpls = dlmread('/net/cheetah/scratch2/aelhosiny/sim4/sim/ovm/remal_toplevel/rtl/passed/remal_test_43_31119_RTL/intrp_input.txt');
%intrp_smpls = dlmread('./passed/remal_test_48_16958_RTL/intrp_output.txt');
% intrp_smpls = dlmread('/net/cheetah/scratch2/aelhosiny/sim4/sim/ovm/remal_toplevel/rtl/passed/remal_test_43_31119_RTL/intrp_output.txt');
intrp_smpls = dlmread('/net/tiger/scratch/aelhosiny/projects/remal/sim/adhoc/interpolator/test_43/simout/intrp_out.txt');

gauss_smpls =  gauss_smpls.*(gauss_smpls<=2^11) + (gauss_smpls-2^12).*(gauss_smpls>2^11);
intrp_smpls =  intrp_smpls.*(intrp_smpls<=2^11) + (intrp_smpls-2^12).*(intrp_smpls>2^11);
%intrp_smpls =  intrp_smpls.*(intrp_smpls<=2^17) + (intrp_smpls-2^18).*(intrp_smpls>2^17);


bit_rate = 2;
intrp_osr = 20;


fltr_fs = bit_rate * 13 * 1000; % Hz
Lfltr = length(gauss_smpls);


intrp_fs = fltr_fs * intrp_osr;
Lintrp = length(intrp_smpls);


NFFT1 = 2^nextpow2(Lfltr); % Next power of 2 from length of y
Y1 = fft(gauss_smpls',NFFT1)/Lfltr;
f1 = fltr_fs*linspace(0,1,NFFT1);

figure

NFFT = NFFT1;
Y = Y1;
f = f1;

% Plot single-sided amplitude spectrum.
% subplot(2,1,1), plot(f,abs(Y(1:NFFT))) 
subplot(2,1,1), semilogy(f,abs(Y(1:NFFT))) 
title('Gaussian samples before interpolation - logscale')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')





%figure

NFFT2 = 2^nextpow2(Lintrp); % Next power of 2 from length of y
Y2 = fft(intrp_smpls',NFFT2)/Lintrp;
f2 = intrp_fs*linspace(0,1,NFFT2);

% Plot single-sided amplitude spectrum.

NFFT = NFFT2;
Y = Y2;
f = f2;

% subplot(2,1,2), plot(f,abs(Y(1:NFFT))) 
subplot(2,1,2), semilogy(f,abs(Y(1:NFFT))) 
title('Gaussian samples after interpolation - logscale')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')




%%%%%%%% Linear Scale Plot

figure

NFFT = NFFT1;
Y = Y1;
f = f1;

% Plot single-sided amplitude spectrum.
subplot(2,1,1), plot(f,abs(Y(1:NFFT))) 
title('Gaussian samples before interpolation')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')



NFFT = NFFT2;
Y = Y2;
f = f2;

subplot(2,1,2), plot(f,abs(Y(1:NFFT))) 
title('Gaussian samples after interpolation')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r = intrp_osr*2;

f21 = f2(1:(length(f2))/r);
Y21 = Y2(1:(length(Y2))/r);


Y = Y21;
f = f21;

figure

subplot(2,1,2), semilogy(f,abs(Y)) 
title('Gaussian samples after interpolation - Main lobe')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')



r = 2;

f11 = f1(1:(length(f1))/r);
Y11 = Y1(1:(length(Y1))/r);


Y = Y11;
f = f11;

subplot(2,1,1), semilogy(f,abs(Y)) 
title('Gaussian samples before interpolation - Main lobe')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Get max value

maxY1 = max(abs(Y1(1:end/2)));
maxY2 = max(abs(Y2(1:end/2)));

attinuation = maxY2/maxY1



%%%%%%%%%%%%%%%%%%%%%%%%%%%
