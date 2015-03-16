clc;
clear all;
close all;

ts_in = 1/625/1e6;
simtime = 1000*ts_in;

R = 4;
mux_sel = 1;

data = csvread('output_156p.csv');

S  = data(:,2);
T  = data(:,1);

TS_all = [T S];

TS = [ TS_all(1:1000,1) TS_all(1:1000,2)];



if R==4
    CWL=11;
    CFL=2;
    SA =3;
elseif R==8
    CWL=9;
    CFL=0;
    SA=5;
else
    CFL=10;
    SA=7;
end

sim('cic_test_mdl.mdl',simtime);