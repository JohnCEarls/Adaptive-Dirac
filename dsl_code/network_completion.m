
% network_completion_prostate

datasets = {'sarcoma_data_small';...
    'breast_GDS807';...
    'lung_GDS2771';...
    'marfan_GDS2960';...
    'crohns_GDS1615';...
    'parkinsons_GDS2519';...
    'bipolar_GDS2190';...
    'leukemia_JHU';...
    'leukemia_GSEA';...
    'squamous_GDS2520';...
    'ovary_GDS2785';...
    'prostate_GDS2545_p_nf';...
    'prostate_GDS2545_m_nf';...
    'prostate_GDS2545_m_p'};
    
network_comp_stats = zeros(numel(datasets),8);

for d = 1:numel(datasets);    
d
load(datasets{d})
load gs_definitions biocarta_gs_defs
load ncbi_genes

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names,biocarta_gs_defs);

G_gs = unique(biocarta_gs_defs(:,3:end));
G_gs_matched = unique(gs_struct.g_gs);
G_missing = setdiff(G_gs,G_gs_matched);

%%
names_new = names;
no_match = [];
for i = 1:numel(G_missing)
    gene_row = find(sum(~cellfun('isempty',...
        strfind(ncbi_gene_list,G_missing{i})),2));
    if numel(gene_row) > 1
        row_idx = [];
        for j = 1:numel(gene_row)

        missing_match_tmp = intersect(ncbi_gene_mat(gene_row(j),:),...
            G_missing{i})';
        if numel(missing_match_tmp)
            missing_match = missing_match_tmp;
            row_idx = j;
        end
        end
        
        names_tmp = lower(regexprep(names,'\-',''));
        match_genes = lower(regexprep(ncbi_gene_mat(gene_row(row_idx),:),'\-',''));
    else
        missing_match = intersect(ncbi_gene_mat(gene_row,:),...
            G_missing{i});
        
        names_tmp = lower(regexprep(names,'\-',''));
        match_genes = lower(regexprep(ncbi_gene_mat(gene_row,:),'\-',''));
    end
    
    [names_match,names_idx] = intersect(names_tmp,match_genes);
    
    if numel(names_match) && numel(missing_match)
        names_new(names_idx) = missing_match;
    else no_match = [no_match; i];
    end
end

save(datasets{d},'names_new','-append')

%%
gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

G_gs_total = gs_struct.G_gs_total;
G_gs_matched = gs_struct.G_gs_matched;
nc_100 = sum(gs_struct.g_gs_match_rate(:,3)>=1);
nc_90 = sum(gs_struct.g_gs_match_rate(:,3)>=.9);
nc_80 = sum(gs_struct.g_gs_match_rate(:,3)>=.8);
nc_70 = sum(gs_struct.g_gs_match_rate(:,3)>=.7);
nc_60 = sum(gs_struct.g_gs_match_rate(:,3)>=.6);
nc_50 = sum(gs_struct.g_gs_match_rate(:,3)>=.5);

network_comp_stats(d,1:8) = [G_gs_total,G_gs_matched,...
    nc_100,nc_90,nc_80,nc_70,nc_60,nc_50];

end