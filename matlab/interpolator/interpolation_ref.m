clear all; close all; clc;

%gauss_smpls = dlmread('fltr_out.txt');
%intrp_smpls = dlmread('intrp_out.txt');

% remal_test_43_31119_RTL 20 
% remal_test_44_10553_RTL 25
% remal_test_45_5699_RTL  40 
% remal_test_46_7851_RTL  50
% remal_test_47_30560_RTL 100

% remal_test_48_16958_RTL 8 
% remal_test_49_31408_RTL 10
% remal_test_50_6641_RTL  16
% remal_test_51_5952_RTL  20
% remal_test_52_2288_RTL  25

% remal_test_53_4351_RTL
% remal_test_54_3624_RTL
% remal_test_55_25562_RTL
% remal_test_56_21447_RTL
% remal_test_57_32025_RTL

% remal_test_58_29_RTL
% remal_test_59_3555_RTL
% remal_test_60_7869_RTL
% remal_test_61_14379_RTL
% remal_test_62_28516_RTL

% remal_test_63_28797_RTL 2
% remal_test_64_19833_RTL 4
% remal_test_65_26539_RTL 5 
% remal_test_66_30998_RTL 10

% remal_test_67_22409_RTL 2
% remal_test_68_2069_RTL  4


% passed/remal_test_55_8621_RTL



K = 8;
M = 1;
osr = 16;


M2 = M+1+5;

gauss_smpls = dlmread('/net/cheetah/scratch2/aelhosiny/sim4/sim/ovm/remal_toplevel/rtl/passed/remal_test_50_6641_RTL/intrp_input.txt');
% intrp_smpls = dlmread('/net/cheetah/scratch2/aelhosiny/sim4/sim/ovm/remal_toplevel/rtl/passed/remal_test_43_31119_RTL/intrp_output.txt');
% arr_size = length(gauss_smpls);




% gauss_smpls = dlmread('/net/cheetah/scratch3/aelhosiny/remal_ca/sim/ovm/remal_toplevel/rtl/remal_test_58_11944_RTL/intrp_input.txt');
% intrp_smpls = dlmread('/net/cheetah/scratch3/aelhosiny/remal_ca/sim/ovm/remal_toplevel/rtl/remal_test_58_11944_RTL/intrp_output.txt');


arr_size = length(gauss_smpls);

gauss_smpls =  gauss_smpls.*(gauss_smpls<=2^11) + (gauss_smpls-2^12).*(gauss_smpls>2^11);
% intrp_smpls =  intrp_smpls.*(intrp_smpls<=2^11) + (intrp_smpls-2^12).*(intrp_smpls>2^11);

% dlmwrite('rtl_in.txt', gauss_smpls, '\r');



%gauss_smpls2 = gauss_smpls;

%gauss_smpls(2:arr_size+1) = gauss_smpls;
%gauss_smpls(1) = 0;
%arr_size = length(gauss_smpls);

gauss_smpls(1:arr_size-1) = gauss_smpls(2:arr_size);

starti = 1;
nsamples = arr_size-1;
%nsamples = 3;

% starti = 36;
% nsamples = starti+41;

% smpl_arry = zeros(1:(arr_size*osr));


for i = starti:nsamples-1
%     gauss_smpls(i+1)
%     gauss_smpls(i)
    delta_s =  gauss_smpls(i+1) - gauss_smpls(i);
    delta_s_km = delta_s * K;
    %gauss_smpls(i)
    %%%%%% Get Epsilon %%%%%%
    if abs(delta_s) > 0
        for j = 1:M2
            %fprintf('calculating epsilon\n');
            if abs(delta_s_km) > 1
                delta_s_km =  floor(delta_s_km/2);
            else
                delta_s_km = 0;
                break
            end
        end
    else
        delta_s_km = 0;
    end
    
    epsilon(i) = delta_s_km;
    %%%%%% Caclculate Trend %%%%%%
    if delta_s > 0
        trend_f = 1;
    elseif delta_s == 0
        trend_f = 0;
    else
        trend_f = 2;
    end

    
    for l = (osr):-1:1
        if l == osr
%             gauss_smpls(i)
            smpl_arry(osr*i-l+1) = gauss_smpls(i);
        else
            new_sample = delta_s_km + smpl_arry(osr*i-l+1-1);
            delta_new = gauss_smpls(i+1) - new_sample;
            %%%%%% Calculate the trend %%%%%%
            
            if delta_new > 0
                trend_i = 1;
            elseif delta_new == 0
                trend_i = 0;
            else
                trend_i = 2;
            end
            %trend_i
            %%%%%% Compare the trend and stop upon trend error %%%%%%
            if (trend_i == trend_f) || delta_new == 0
                %fprintf('same trend');
                %osr*i-l+1
                smpl_arry(osr*i-l+1) = new_sample;
            else
                %fprintf('trend error');
                %new_sample = smpl_arry(osr*i-l)
                smpl_arry(osr*i-l+1) = smpl_arry(osr*i-l);
            end
            %smpl_arry(osr*i-l+1) = delta_s_km + smpl_arry(osr*i-l+1-1);
        end
    end
end

dlmwrite('intrp_ref.txt', smpl_arry, '\r');
% dlmwrite('epsilon.txt', epsilon, '\r');
%dlmwrite('rtl_out.txt', intrp_smpls, '\r');
dlmwrite('rtl_in.txt', gauss_smpls, '\r');


simend = 1