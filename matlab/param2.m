close all ; clear all; clc;

fs_in = 600e6;
simtime=1;
sq_wave_freq=100;
osr=100;
osr_dash=osr*sq_wave_freq;
fs=sq_wave_freq*osr;
t_vec = linspace(0,simtime,simtime*osr_dash);
t_vec = t_vec';
tsq = square(2*pi*sq_wave_freq*t_vec);
sq_vec=[t_vec tsq];
%plot(t_vec,tsq);



%tsim = 1/fs_in * length(t_vec);

sim('cic2.mdl', 1);

% xdft = (1/length(tsq))*fft(tsq); 
% freq = -fs/2:(fs/length(tsq)):fs/2-(fs/length(tsq)); 
% plot(freq,abs(fftshift(xdft)));

plot_spectrum(tsq,fs);


% cic1_out = logsout.cic1_out.Data;
% cic2_out = logsout.cic2_out.Data;


plot_spectrum(cic4_out, fs/4);
plot_spectrum(cic8_out, fs/8);