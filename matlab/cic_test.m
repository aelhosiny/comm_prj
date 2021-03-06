clc;
clear all;
close all;

fs_in = 625e6;
ts_in = 1/625/1e6;


R = 16;
mux_sel = 3;

% data = csvread('output_156p.csv');
data = csvread('./TDC_2ndOrder/output_156p.csv');

S  = data(:,2);
% T  = data(:,1);
T = linspace(1, length(S), length(S));
T = T'.*ts_in;

% simtime = sum(T);

TS_all = [T S];
% TS = [ TS_all(1:1000,1) TS_all(1:1000,2)];
TS = TS_all;

simtime = (length(TS))*ts_in;



lf_param;
sim('cic_test_mdl.mdl',simtime);

cic_out_f = cic_out.*2^15;
% cic_out_f1 = cic_out1.*2^5;
% sec1_out_f = sec1_out.*2^5;
% sec1_in_f = sec1_in.*2^5;
% sec2_out_f = sec2_out.*2^5;
% sec2_out1_f = sec2_out1.*2^5;
% lf_out_f = lf_out.*2^18;

file_out = strcat('cic_out_',num2str(R),'.txt');
dlmwrite(file_out, cic_out_f, '\r');
dlmwrite('cic_out1.txt', cic_out_f, '\r');

% dlmwrite('lf_out.txt', lf_out_f, '\r');

% dlmwrite('sec1_out.txt', sec1_out_f, '\r');
% dlmwrite('sec1_in.txt', sec1_in_f, '\r');
% dlmwrite('sec2_out.txt', sec2_out_f, '\r');
% dlmwrite('sec2_out1.txt', sec2_out1_f, '\r');

% t1 = linspace(1,length(cic_in),length(cic_in));
% t1 = t1.*ts_in;
% figure
% subplot(2,1,1) ; plot(t1,cic_in); grid on;
% t1 = linspace(1,length(cic_out),length(cic_out));
% t1 = t1.*ts_in*R;
% subplot(2,1,2) ; plot(t1,cic_out); grid on;
% 
% plot_spectrum(cic_in, fs_in);
% plot_spectrum(cic_out, fs_in/R);
% plot_spectrum(lf_out1, fs_in/R);
% plot_spectrum(lf_out, fs_in/R);
plot_spectrum(lf2_out, fs_in/R);
% plot_spectrum(cic_out1, fs_in/R);

% plot_tf(cic_out, lf_out, fs_in/R);
