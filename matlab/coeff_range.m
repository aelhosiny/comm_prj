clear all;
close all;
clc;

B1_mat = zeros(6,1);
B2_mat = zeros(6,1);

A1_mat = zeros(6,1);
A2_mat = zeros(6,1);
A3_mat = zeros(6,1);

for sweep_coeff=1:8
    lf_param;
    B1_mat(sweep_coeff) = B1;
    B2_mat(sweep_coeff) = B2;
    A1_mat(sweep_coeff) = A1;
    A2_mat(sweep_coeff) = A2;
    A3_mat(sweep_coeff) = A3;
end

A2_mat = A2_mat.*2^14;
A3_mat = A3_mat.*2^14;

B1_mat = B1_mat.*2^22;
B2_mat = B2_mat.*2^22;


coeff_mat = [B1_mat B2_mat A2_mat A3_mat];
dlmwrite('./coeff.txt',coeff_mat);