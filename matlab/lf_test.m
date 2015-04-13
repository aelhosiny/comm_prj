clear all;
close all;
clc;

fs_in = 625e6;
R = 16;
fs = fs_in/R;

K1_min=70;
K1_max=248;

K2_max=0.0253754;
K2_min=0.00205994;

K3_max=0.90625;
K3_min=0.850128;

sweep_coeff=4;

if (sweep_coeff==1)
    K2=K2_min;
    K3=K3_min;
    K1=K1_min;
elseif (sweep_coeff==2)
    K2=K2_max;
    K3=K3_max;
    K1=K1_max;
elseif sweep_coeff==3
    K2=K2_max;
    K3=K3_min;
    K1=K1_max;
elseif sweep_coeff==4
    K2=K2_min;
    K3=K3_max;
    K1=K1_min;
end



% file_in = strcat('cic_out_',num2str(R),'.txt');
% lf_in = dlmread(file_in, '\r');
% 
% t = linspace(1,length(lf_in), length(lf_in));
% t = t.*ts;
% t=t';
% 
% lf_in_mat = [t lf_in];
% 
% simtime = (length(lf_in_mat))*ts;

tones;

simtime = 1/fs * length(tone_in);

sim('lf.mdl', simtime);


plot_spectrum(lf_out, fs);
