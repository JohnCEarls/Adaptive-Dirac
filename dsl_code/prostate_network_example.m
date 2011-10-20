
% prostate DIRAC

%% primary vs. normal (free)
d = 1;
load Datasets\'Prostate (GDS2545)'\prostate_GDS2545_p_nf
load lc_gs_defs prostate_GDS2545_m_nf_lc_gs_defs
biocarta_gs_defs = prostate_GDS2545_m_nf_lc_gs_defs;

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

cd 'Core Functions'
gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1_gs,mu_R_1_stats,mu_R_2_gs,mu_R_2_stats] = mu_R(gs_struct,groups);
mu_R_struct(d).name = 'primary_normal';
mu_R_struct(d).mu_R_1_gs = mu_R_1_gs;
mu_R_struct(d).mu_R_1_stats = mu_R_1_stats;
mu_R_struct(d).mu_R_2_gs = mu_R_2_gs;
mu_R_struct(d).mu_R_2_stats = mu_R_2_stats;
save ../lc_mu_R_struct_prostate mu_R_struct

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,10);
mu_diff_struct(d).name = 'primary_normal';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save ../lc_mu_diff_struct_prostate mu_diff_struct

[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,10);
[classifiers,results] = eta_loocv(gs_struct,groups,1);
eta_struct(d).name = 'primary_normal';
eta_struct(d).gs = eta_gs;
eta_struct(d).stats = eta_stats;
eta_struct(d).accuracy = results(5);
save ../lc_eta_struct_prostate eta_struct
clear
clc
cd ..

%% metastatic vs. normal (free)
d = 2;
load Datasets\'Prostate (GDS2545)'\prostate_GDS2545_m_nf
load lc_gs_defs prostate_GDS2545_m_nf_lc_gs_defs
load lc_mu_R_struct_prostate
load lc_mu_diff_struct_prostate
load lc_eta_struct_prostate
biocarta_gs_defs = prostate_GDS2545_m_nf_lc_gs_defs;

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

cd 'Core Functions'
gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1_gs,mu_R_1_stats,mu_R_2_gs,mu_R_2_stats] = mu_R(gs_struct,groups);
mu_R_struct(d).name = 'metastatic_normal';
mu_R_struct(d).mu_R_1_gs = mu_R_1_gs;
mu_R_struct(d).mu_R_1_stats = mu_R_1_stats;
mu_R_struct(d).mu_R_2_gs = mu_R_2_gs;
mu_R_struct(d).mu_R_2_stats = mu_R_2_stats;
save ../lc_mu_R_struct_prostate mu_R_struct

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,100);
mu_diff_struct(d).name = 'metastatic_normal';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save ../lc_mu_diff_struct_prostate mu_diff_struct

[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,100);
[classifiers,results] = eta_loocv(gs_struct,groups,1);
eta_struct(d).name = 'metastatic_normal';
eta_struct(d).gs = eta_gs;
eta_struct(d).stats = eta_stats;
eta_struct(d).accuracy = results(5);
save ../lc_eta_struct_prostate eta_struct
clear
clc
cd ..

%% metastatic vs. primary
d = 3;
load Datasets\'Prostate (GDS2545)'\prostate_GDS2545_m_p
load lc_gs_defs prostate_GDS2545_m_nf_lc_gs_defs
load lc_mu_R_struct_prostate
load lc_mu_diff_struct_prostate
load lc_eta_struct_prostate
biocarta_gs_defs = prostate_GDS2545_m_nf_lc_gs_defs;

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

cd 'Core Functions'
gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1_gs,mu_R_1_stats,mu_R_2_gs,mu_R_2_stats] = mu_R(gs_struct,groups);
mu_R_struct(d).name = 'metastatic_primary';
mu_R_struct(d).mu_R_1_gs = mu_R_1_gs;
mu_R_struct(d).mu_R_1_stats = mu_R_1_stats;
mu_R_struct(d).mu_R_2_gs = mu_R_2_gs;
mu_R_struct(d).mu_R_2_stats = mu_R_2_stats;
save ../lc_mu_R_struct_prostate mu_R_struct

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,100);
mu_diff_struct(d).name = 'metastatic_primary';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save ../lc_mu_diff_struct_prostate mu_diff_struct

[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,100);
[classifiers,results] = eta_loocv(gs_struct,groups,1);
eta_struct(d).name = 'metastatic_primary';
eta_struct(d).gs = eta_gs;
eta_struct(d).stats = eta_stats;
eta_struct(d).accuracy = results(5);
save ../lc_eta_struct_prostate eta_struct
clear
clc
cd ..
