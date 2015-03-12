fs_in = 625e6;

t_vec = linspace(1,100,1000);
t_vec = t_vec';
tsq = square(t_vec);

tsim = 1/fs_in * length(t_vec);

sim('cic1.mdl', 'StopTime', 'tsim');