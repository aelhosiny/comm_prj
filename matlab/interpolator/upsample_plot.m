%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Upsampling
clear all; close all; clc;

bitrate = 2;
osr = 25;

gauss_smpls = dlmread('/net/cheetah/scratch2/aelhosiny/sim4/sim/ovm/remal_toplevel/rtl/passed/remal_test_44_10553_RTL/intrp_input.txt');
upsmp_r = 500;
osr1  = 1;
upsample(gauss_smpls, upsmp_r, bitrate, osr1);


intrp_smpls = dlmread('/net/cheetah/scratch2/aelhosiny/sim4/sim/ovm/remal_toplevel/rtl/passed/remal_test_44_10553_RTL/intrp_output.txt');
upsmp_r = 50;
upsample(intrp_smpls, upsmp_r, bitrate, osr);

smpls_after = dlmread('/net/tiger/scratch/aelhosiny/projects/remal/sim/adhoc/interpolator/test_44/simout/intrp_out.txt');
upsmp_r = 50;
upsample(smpls_after, upsmp_r, bitrate, osr);


