function [] = plot_td(samples)

%% Function Body

size1 = length(samples);

t = linspace(0,1,size1);

figure

plot(t, samples);