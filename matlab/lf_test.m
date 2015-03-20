clear all;
close all;
clc;

K1=122;
K2=0.1328;
K3=0.90625;

ts_in = 1/625/1e6;
R = 8;
ts = R*ts_in;


file_in = strcat('cic_out_',num2str(R),'.txt');
lf_in = dlmread(file_in, '\r');

t = linspace(1,length(lf_in), length(lf_in));
t = t.*ts;
t=t';

lf_in_mat = [t lf_in];

simtime = (length(lf_in_mat))*ts;

sim('IIR1.mdl', simtime);

% plot_spectrum(lf_in1, 1/ts);
plot_spectrum(lf_out1, 1/ts);
plot_spectrum(lf_out, 1/ts);