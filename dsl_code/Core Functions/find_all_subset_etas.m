function subset_etas = ...
    find_all_subset_etas(seeds, E_log10_QN, names_new, groups, max_network_length, num_permuts)
% obtain max values of eta for each seed networks' preceding subsets of size 2 up to k-1.
%   Note that values may change for previous eta's as 'new' maximums for
%   each cardinality are found. It is assumed that, for the seeds' subsets,
%   a set of size k has greater eta than a set of size k-1, for any k.
%   Additionally, assume the best subset of size k-2 is also a subset 
%   of the best subset of size k-1. 
%   (this is likely false, but yields some simplification)

% -2-1: discount name,na fields and no subsets of |1| are used
subset_etas = zeros(length(seeds), max_network_length-2-1);
for i = 1:size(seeds)
    cur_network = seeds(i,:);
    gs = gs_match_id(E_log10_QN, names_new, cur_network);
    [eta_gs,eta_stats] = eta_fdr(gs, groups, num_permuts);
    subset_etas(i,1:end) = eta_stats(1,5);
end

%for i = 1:size(seeds)
%    cur_network = seeds(i,:);
%    subsets = generate_subsets(cur_network);
%    gs_subsets = gs_match_id(E_log10_QN, names_new, subsets);
%    base = gs_subsets.G_gs_matched;
%    for j = 2:base-1
%        [eta_gs,eta_stats] = eta_fdr(gs_subsets, groups, num_permuts);        
%        subset_etas(i, base-j) = eta_stats(1,5);
%        cur_network = ['name' 'na' gs_subsets.g_gs(eta_stats(1,1), :)];
%        subsets = generate_subsets(cur_network);
%        gs_subsets = gs_match_id(E_log10_QN, names_new, subsets);
%    end
%end