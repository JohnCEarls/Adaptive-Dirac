function plot_sffs_eta_trace(sffs_eta_trace)

[num_networks, num_iterations] = size(sffs_eta_trace{1,1});
x = 1:num_iterations;

hold all
for i=1:num_networks
    plot(x, sffs_eta_trace{1,1}(i,:));
end