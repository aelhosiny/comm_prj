% clear all;
% close all;
% clc;




sweep_coeff=1;

if (sweep_coeff==1)
    K1=248;
    K2=0.00205994;
    K3=0.952011;
elseif (sweep_coeff==2)
    K1=164;
    K2=0.00465393;
    K3=0.908447;
elseif sweep_coeff==3
    K1=124;
    K2=0.00828552;
    K3=0.908447;
elseif sweep_coeff==4
    K1=98;
    K2=0.0129547;
    K3=0.888123;
elseif sweep_coeff==5
    K1=82;
    K2=0.0186462;
    K3=0.868683;    
elseif sweep_coeff==6
    K1=70;
    K2=0.0253754;
    K3=0.850128;    
end




B1 = K2*(1-K3)*(1+K1);
B2 = -K1*K2*(1-K3);


% M = 1.0001;
% 
% A1 = M;
% A2 = -(1+M*K3);
% A3 = K3;

M = 1/1.0001;

A1 = 1;
A2 = -(M+K3);
A3 = K3*M;