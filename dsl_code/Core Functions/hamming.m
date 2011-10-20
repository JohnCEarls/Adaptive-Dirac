function [hdist, hdist_indx] = hamming(gs_struct, groups)

X = gs_struct.X;
groups = groups(:);

g_gs_idx = gs_struct.g_gs_idx;
keep_gs = find(sum(g_gs_idx > 0, 2) > 2);
g_gs_idx = g_gs_idx(keep_gs,:);
M = size(g_gs_idx,1);

gs = gs_struct.gs(keep_gs);
G_gs = gs_struct.g_gs_match_rate(keep_gs,1);
G_pairs = zeros(M,1);
for m = 1:M
    G_pairs(m) = G_gs(m)*(G_gs(m)-1)/2;
end

% Calculate rank matching scores for class 1 and 2
[R_1,R_2, templates] = rank_matching(X,g_gs_idx,'train',groups);

hdist = zeros(length(templates),1);
for i=1:length(templates)
    hdist(i) = pdist([templates(i).T_1'; templates(i).T_2'], 'hamming');
end

[hdist, hdist_indx] = sort(hdist);
