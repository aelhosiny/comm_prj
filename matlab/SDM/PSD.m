clear all
clc
close all 

tsim=65535;
% tsim=30000;

% set(0,'DefaultTextFontName','Times',...
% 'DefaultTextFontSize',14,...
% 'DefaultTextFontWeight','Bold',...
% 'DefaultAxesFontName','Times',...
% 'DefaultAxesFontSize',14,...
% 'DefaultAxesFontWeight','Bold',...
% 'DefaultLineLineWidth',3,...
% 'DefaultLineMarkerSize',7.75,...
% 'defaultlinemarkersize',8)
 
fs = 38.4e6 ;                % Sampling frequency 
Nin = 16 ;                   % Number of SDM input bits
FRAC = 16385 ;               % SDM input value
w = 17;

% sdm_in = FRAC/2^Nin
sdm_in = FRAC;
%model = 'MASH111';
model = 'sdm_new';
sim(model,tsim)

NFFT = length(sdm_out) ;  
mask = hann(NFFT, 'periodic') ;
[p,f] = periodogram(sdm_out,mask,NFFT,fs) ;

% Plotting PSD
figure
semilogx(f,10.*log10(p),'r')
grid on
xlim([1e3 fs/2])
xlabel('Frequency [Hz]')
ylabel('Power Spectral Density [dB/Hz]')

t1 = linspace(1, length(sdm_out), length(sdm_out));

% 
% 
% dlmwrite('sdm_out.txt', sdm_out, '\r');
% dlmwrite('sec1_out.txt', sec1_out, '\r');
% dlmwrite('sub1_out.txt', sub1_out, '\r');
% dlmwrite('sub1_in2.txt', sub1_in2, '\r');
% dlmwrite('int1_out.txt', sub1_in2, '\r');

% close all;
% figure
% t1 = linspace(1, length(int1_out), length(int1_out));
% t1 = t1';
% l1 = ones(length(int1_out),1);
% l1 = l1.*2^17;
% l2 = l1.*2^16;
% plot (t1, int1_out);
% hold on;
% plot (t1, l1, 'r');
% hold on;
% plot (t1, l2, 'r'); grid on
% 
% figure
% plot (t1, int1_in); grid on
