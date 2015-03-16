clc;
clear all;
close all;

fs_in = 625e6;
ts_in = 1/625/1e6;
simtime = 1000*ts_in;

R = 16;
mux_sel = 3;

data = csvread('output_156p.csv');

S  = data(:,2);
% T  = data(:,1);
T = linspace(1, length(S), length(S));
T = T'.*ts_in;

TS_all = [T S];

% TS = [ TS_all(1:1000,1) TS_all(1:1000,2)];
TS = TS_all;

if R==4
    SA =3;
elseif R==8
    SA=5;
else
    SA=7;
end

sim('cic_test_mdl.mdl',simtime);
plot_spectrum(cic_in, fs_in);
plot_spectrum(cic_out, fs_in/R);

cic_out_f = cic_out.*2^8;
file_out = strcat('cic_out_',num2str(R),'.txt');
dlmwrite(file_out, cic_out_f, '\r');

t1 = linspace(1,length(cic_in),length(cic_in));
figure
subplot(2,1,1) ; plot(t1,cic_in); grid on;
t1 = linspace(1,length(cic_out),length(cic_out));
subplot(2,1,2) ; plot(t1,cic_out); grid on;