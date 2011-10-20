
% prostate DIRAC

% primary vs. normal (free)
d = 1
load prostate_GDS2545_p_nf
load gs_definitions biocarta_gs_defs

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1_gs,mu_R_1_stats,mu_R_2_gs,mu_R_2_stats] = ...
    mu_R_fdr(gs_struct,groups,1);
mu_R_struct(d).name = 'primary_normal_free'
mu_R_struct(d).mu_R_1_gs = mu_R_1_gs;
mu_R_struct(d).mu_R_1_stats = mu_R_1_stats;
mu_R_struct(d).mu_R_2_gs = mu_R_2_gs;
mu_R_struct(d).mu_R_2_stats = mu_R_2_stats;
save mu_R_struct_prostate_021710 mu_R_struct

[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1000);
[classifiers,results] = eta_loocv(gs_struct,groups,1);

eta_struct(d).name = 'primary_normal_free'
eta_struct(d).gs = eta_gs;
eta_struct(d).stats = eta_stats;
eta_struct(d).accuracy = results(5);
save eta_struct_prostate_021710 eta_struct
clear
clc

% metastatic vs. normal (free)
d = 2
load prostate_GDS2545_m_nf
load gs_definitions biocarta_gs_defs
load mu_R_struct_prostate_021710
load eta_struct_prostate_021710

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1_gs,mu_R_1_stats,mu_R_2_gs,mu_R_2_stats] = ...
    mu_R_fdr(gs_struct,groups,1);
mu_R_struct(d).name = 'metastatic_normal_free'
mu_R_struct(d).mu_R_1_gs = mu_R_1_gs;
mu_R_struct(d).mu_R_1_stats = mu_R_1_stats;
mu_R_struct(d).mu_R_2_gs = mu_R_2_gs;
mu_R_struct(d).mu_R_2_stats = mu_R_2_stats;
save mu_R_struct_prostate_021710 mu_R_struct

[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1000);
[classifiers,results] = eta_loocv(gs_struct,groups,1);

eta_struct(d).name = 'metastatic_normal_free'
eta_struct(d).gs = eta_gs;
eta_struct(d).stats = eta_stats;
eta_struct(d).accuracy = results(5);
save eta_struct_prostate_021710 eta_struct
clear
clc

% metastatic vs. primary
d = 3
load prostate_GDS2545_m_p
load gs_definitions biocarta_gs_defs
load mu_R_struct_prostate_021710
load eta_struct_prostate_021710

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);

[mu_R_1_gs,mu_R_1_stats,mu_R_2_gs,mu_R_2_stats] = ...
    mu_R_fdr(gs_struct,groups,1);
mu_R_struct(d).name = 'metastatic_primary'
mu_R_struct(d).mu_R_1_gs = mu_R_1_gs;
mu_R_struct(d).mu_R_1_stats = mu_R_1_stats;
mu_R_struct(d).mu_R_2_gs = mu_R_2_gs;
mu_R_struct(d).mu_R_2_stats = mu_R_2_stats;
save mu_R_struct_prostate_021710 mu_R_struct

[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1000);
[classifiers,results] = eta_loocv(gs_struct,groups,1);

eta_struct(d).name = 'metastatic_primary'
eta_struct(d).gs = eta_gs;
eta_struct(d).stats = eta_stats;
eta_struct(d).accuracy = results(5);
save eta_struct_prostate_021710 eta_struct
clear
clc
