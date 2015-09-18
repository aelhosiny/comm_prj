% sweep_coeff=8;

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

A_FL=16;
B_FL=15;

A2_rtl = -A2*2^A_FL;
A3_rtl = A3*2^A_FL;
B1_rtl = B1*2^B_FL;
B2_rtl = -B2*2^B_FL;


% p1 = 0.99;
% p2 = 0.99;
% 
% p1 = 0.9749;
% p2 = 0.998;
% 
% A2 = (p1+p2)
% A3=p1*p2
