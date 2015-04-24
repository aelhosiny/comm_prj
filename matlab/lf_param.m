% clear all;
% close all;
% clc;


sweep_coeff=1;

if (sweep_coeff==1)
    K1=476;
    K2=0.000488281;
    K3=0.974426;
elseif (sweep_coeff==2)
    K1=238;
    K2=0.00198364;
    K3=0.950119;
elseif sweep_coeff==3
    K1=158;
    K2=0.00447083;
    K3=0.927002;
elseif sweep_coeff==4
    K1=118;
    K2=0.00794983;
    K3=0.904999;
elseif sweep_coeff==5
    K1=94;
    K2=0.0124359;
    K3=0.884003;    
elseif sweep_coeff==6
    K1=78;
    K2=0.0179138;
    K3=0.863953;  
elseif sweep_coeff==7
    K1=68;
    K2=0.0243683;
    K3=0.844849; 
elseif sweep_coeff==8
    K1=58;
    K2=0.0318451;
    K3=0.826477;     
end




B1 = K2*(1-K3)*(1+K1);
B2 = -K1*K2*(1-K3);


% M = 1.0001;
% 
% A1 = M;
% A2 = -(1+M*K3);
% A3 = K3;

M = ((2^9)-1)/(2^9);

A1 = 1;
A2 = -(M+K3);
A3 = K3*M;