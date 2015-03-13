%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ideal Interpolation
clc; clear all; close all;

gauss_smpls = dlmread('/net/cheetah/scratch2/aelhosiny/sim4/sim/ovm/remal_toplevel/rtl/passed/remal_test_44_10553_RTL/intrp_input.txt');
gauss_smpls =  gauss_smpls.*(gauss_smpls<=2^11) + (gauss_smpls-2^12).*(gauss_smpls>2^11);


bitrate = 2;
osr = 25;
fs = bitrate * osr * 13 * 1000;


arr_size = length(gauss_smpls);

smpl_arry_idl = zeros(1,(arr_size*osr));

for i = 1:arr_size-1
    delta_s =  gauss_smpls(i+1) - gauss_smpls(i);
    epsilon = delta_s/osr;
    for l = (osr):-1:1
        if l == osr
            smpl_arry_idl(osr*i-l+1) = gauss_smpls(i);
        else
            smpl_arry_idl(osr*i-l+1)  = epsilon + smpl_arry_idl(osr*i-l+1-1);
        end
    end
end



plot_fft(gauss_smpls, 1, fs/osr);
plot_td(gauss_smpls);

plot_fft(smpl_arry_idl, 1, fs);
plot_td(smpl_arry_idl);



simend = 1