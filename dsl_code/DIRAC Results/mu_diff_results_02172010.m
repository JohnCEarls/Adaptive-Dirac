% mu_diff_results

d=1
load sarcoma_data_small
load gs_definitions biocarta_gs_defs

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'GIST_LMS';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=2
load breast_GDS807
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'breast_cancer';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=3
load lung_GDS2771
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'lung_cancer';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=4
load marfan_GDS2960
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'marfan_syndrome';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=5
load crohns_GDS1615
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'crohns_disease';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=6
load parkinsons_GDS2519
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'parkinsons_disease';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=7
load bipolar_GDS2190
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'bipolar_disorder';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=8
load leukemia_JHU
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'leukemia_JHU';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=9
load leukemia_GSEA
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'leukemia_GSEA';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2]; % deal with this
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=10
load squamous_GDS2520
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'squamous_carcinoma';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear

d=11
load ovary_GDS2785
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'ovarian_cancer';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=12
load prostate_GDS2545_p_nf
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'prostate_cancer';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=13
load prostate_GDS2545_m_nf
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'metastatic_prostate_cancer';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear


d=14
load prostate_GDS2545_m_p
load gs_definitions biocarta_gs_defs
load mu_diff_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1000);

mu_diff_struct(d).name = 'prostate_cancer_progression';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save mu_diff_struct_02172010 mu_diff_struct
clear