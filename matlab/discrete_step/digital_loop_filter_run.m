clc;
clear all;
close all;

fs_in = 625e6;
ts_in = 1/625/1e6;
% This variable changes the filter curve
% range 1 => 8
% each curve corresponds to different coefficients
sweep_coeff=8;


%% Change step value output from TDC to decimator
% range -16 => 15
% some value need more time to settle...
% increase r1 to give more time for the filter to settle
step = -4;
r1=500;

%% Prepare the input stimulus and run simulation
x1=ones(r1,1);
x1=x1.*step;

S = x1;
T = linspace(1, length(S), length(S));
T = T'.*ts_in;
shift=0;


TS_all = [T S];
TS = TS_all;

simtime = (length(TS))*ts_in;


lf_param;
sim('digital_loop_filter.mdl',simtime);



%% Plot the results
% the blue curve is the TDC output
% the green curve is the filter output
cic_in1=cic_in;
lf_out1=lf_out;

figure
subplot(2,1,1);
t1=linspace(0,1,length(cic_in1));
t1=t1';
t1=ts_in*t1;
plot(t1,cic_in1,'b'); grid on;
hold on
subplot(2,1,2);
t1=linspace(0,1,length(lf_out1));
t1=t1';
t1=ts_in*t1*16;
plot(t1,lf_out1,'g'); grid on;