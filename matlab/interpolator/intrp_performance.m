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



smpls_before = dlmread('/net/cheetah/scratch2/aelhosiny/sim4/sim/ovm/remal_toplevel/rtl/passed/remal_test_49_31408_RTL/intrp_output.txt');
smpls_after = dlmread('/net/tiger/scratch/aelhosiny/projects/remal/sim/adhoc/interpolator/test_49/simout/intrp_out.txt');

smpls_before =  smpls_before.*(smpls_before<=2^11) + (smpls_before-2^12).*(smpls_before>2^11);
smpls_after =  smpls_after.*(smpls_after<=2^11) + (smpls_after-2^12).*(smpls_after>2^11);


bit_rate = 5;
intrp_osr = 10;



intrp_fs = bit_rate * 13 * 1000 * intrp_osr;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot spectrun before and after bug fixing

% Samples before
L1 = length(smpls_before);
NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of y
Y1 = fft(smpls_before',NFFT1)/L1;
f1 = intrp_fs*linspace(0,1,NFFT1);

% Samples After

L2 = length(smpls_after);
NFFT2 = 2^nextpow2(L2); % Next power of 2 from length of y
Y2 = fft(smpls_after',NFFT2)/L2;
f2 = intrp_fs*linspace(0,1,NFFT2);



figure

NFFT = NFFT1;
Y = Y1;
f = f1;

% Plot single-sided amplitude spectrum.
% subplot(2,1,1), plot(f,abs(Y(1:NFFT))) 
subplot(2,1,1), semilogy(f,abs(Y(1:NFFT))) 
title('Spectrum before bug fixing - logscale')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')


NFFT = NFFT2;
Y = Y2;
f = f2;

% subplot(2,1,2), plot(f,abs(Y(1:NFFT))) 
subplot(2,1,2), semilogy(f,abs(Y(1:NFFT))) 
title('Spectrum after bug fixing - logscale')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

