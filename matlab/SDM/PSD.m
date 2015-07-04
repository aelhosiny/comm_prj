clear all
clc
close all 

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
FRAC = 26625 ;               % SDM input value
w = 17;

% sdm_in = FRAC/2^Nin
sdm_in = FRAC;
model = 'MASH111';
sim(model)

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

% 
% 
% dlmwrite('sdm_out.txt', sdm_out, '\r');
% dlmwrite('sec1_out.txt', sec1_out, '\r');
% dlmwrite('sub1_out.txt', sub1_out, '\r');
% dlmwrite('sub1_in2.txt', sub1_in2, '\r');
% dlmwrite('int1_out.txt', sub1_in2, '\r');
