% clear all;
% close all;
% clc;


sweep_coeff=8;

% if (sweep_coeff==1)
%     B1=476;
%     B2=0.000488281;
%     A2=0.974426;
% elseif (sweep_coeff==2)
%     B1=238;
%     B2=0.00198364;
%     A2=0.950119;
% elseif sweep_coeff==3
%     B1=158;
%     B2=0.00447083;
%     A2=0.927002;
% elseif sweep_coeff==4
%     B1=118;
%     B2=0.00794983;
%     A2=0.904999;
% elseif sweep_coeff==5
%     B1=94;
%     B2=0.0124359;
%     A2=0.884003;    
% elseif sweep_coeff==6
%     B1=78;
%     B2=0.0179138;
%     A2=0.863953;  
% elseif sweep_coeff==7
%     B1=68;
%     B2=0.0243683;
%     A2=0.844849; 
% elseif sweep_coeff==8
%     B1=58;
%     B2=0.0318451;
%     A2=0.826477;     
% end
% 
% 
% 
% 
% B1 = K2*(1-K3)*(1+K1);
% B2 = -K1*K2*(1-K3);
% 
% 
% M = ((2^9)-1)/(2^9);
% 
% A1 = 1;
% A2 = -(M+K3);
% A3 = K3*M;


if (sweep_coeff==1)
    B1=0.0497275;
    B2=0.0496257;
    A2=1.97294;
    A3=0.972991;
elseif (sweep_coeff==2)
    B1=0.194529;
    B2=0.193734;
    A2=1.94909;
    A3=0.94919;
elseif sweep_coeff==3
    B1=0.428105;
    B2=0.425486;
    A2=1.9264;
    A3=0.92654;
elseif sweep_coeff==4
    B1=0.744759;
    B2=0.738697;
    A2=1.90476;
    A3=0.904946;
elseif sweep_coeff==5
    B1=1.13937;
    B2=1.1278;
    A2=1.88411;
    A3=0.884335;
elseif sweep_coeff==6
    B1=1.60777;
    B2=1.58822;
    A2=1.86436;
    A3=0.86463;
elseif sweep_coeff==7
    B1=2.1436;
    B2=2.11325;
    A2=1.84554;
    A3=0.845842;
elseif sweep_coeff==8
    B1=2.74759;
    B2=2.70322;
    A2=1.82742;
    A3=0.827764;
end



c = [1 -A2 A3];
roots(c)

% p1 = 0.99;
% p2 = 0.99;
% 
% p1 = 0.9749;
% p2 = 0.998;
% 
% A2 = (p1+p2)
% A3=p1*p2
