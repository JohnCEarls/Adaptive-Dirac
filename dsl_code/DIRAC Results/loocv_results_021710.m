% loocv_results


% d=1
% load sarcoma_data_small
% load gs_definitions biocarta_gs_defs
% 
% if sum(sum(isnan(E_log10_QN)))
%     notnan = find(sum(isnan(E_log10_QN),2)==0);
%     names = names(notnan);
%     E_log10_QN = E_log10_QN(notnan,:);
% end
% 
% gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
% [eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
% G_m = eta_stats(1,2);
% 
% [classifiers,results] = eta_loocv(gs_struct,groups,1);
% eta_struct(d).name = 'GIST_LMS';
% eta_struct(d).accuracy = results(5);
% save eta_struct_02172010 eta_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
% tsp_small_struct(d).name = 'GIST_LMS';
% tsp_small_struct(d).accuracy = results(5);
% tsp_small_struct(d).G_m = G_m;
% save tsp_small_struct_02172010 tsp_small_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups);
% tsp_struct(d).name = 'GIST_LMS';
% tsp_struct(d).accuracy = results(5);
% save tsp_struct_02172010 tsp_struct
% 
% [h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
% svm_struct(d).name = 'GIST_LMS';
% svm_struct(d).accuracy = results(1,5);
% svm_struct(d).accuracy2 = results(2,5);
% svm_struct(d).G_m = G_m;
% save svm_struct_02172010 svm_struct
% clear
% 
% 
% d=2
% load breast_GDS807
% load gs_definitions biocarta_gs_defs
% load eta_struct_02172010
% load tsp_small_struct_02172010
% load tsp_struct_02172010
% load svm_struct_02172010
% 
% if sum(sum(isnan(E_log10_QN)))
%     notnan = find(sum(isnan(E_log10_QN),2)==0);
%     names = names(notnan);
%     E_log10_QN = E_log10_QN(notnan,:);
% end
% 
% gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
% [eta_gs,eta_stats] = eta_fdr(gs_struct,groups,500);
% G_m = eta_stats(1,2);
% 
% [classifiers,results] = eta_loocv(gs_struct,groups,1);
% eta_struct(d).name = 'breast_cancer';
% eta_struct(d).accuracy = results(5);
% save eta_struct_02172010 eta_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
% tsp_small_struct(d).name = 'breast_cancer';
% tsp_small_struct(d).accuracy = results(5);
% tsp_small_struct(d).G_m = G_m;
% save tsp_small_struct_02172010 tsp_small_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups);
% tsp_struct(d).name = 'breast_cancer';
% tsp_struct(d).accuracy = results(5);
% save tsp_struct_02172010 tsp_struct
% 
% [h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
% svm_struct(d).name = 'breast_cancer';
% svm_struct(d).accuracy = results(1,5);
% svm_struct(d).accuracy2 = results(2,5);
% svm_struct(d).G_m = G_m;
% save svm_struct_02172010 svm_struct
% clear
% 
% 
% d=3
% load lung_GDS2771
% load gs_definitions biocarta_gs_defs
% load eta_struct_02172010
% load tsp_small_struct_02172010
% load tsp_struct_02172010
% load svm_struct_02172010
% 
% if sum(sum(isnan(E_log10_QN)))
%     notnan = find(sum(isnan(E_log10_QN),2)==0);
%     names = names(notnan);
%     E_log10_QN = E_log10_QN(notnan,:);
% end
% 
% gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
% [eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
% G_m = eta_stats(1,2);
% 
% [classifiers,results] = eta_loocv(gs_struct,groups,1);
% eta_struct(d).name = 'lung_cancer';
% eta_struct(d).accuracy = results(5);
% save eta_struct_02172010 eta_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
% tsp_small_struct(d).name = 'lung_cancer';
% tsp_small_struct(d).accuracy = results(5);
% tsp_small_struct(d).G_m = G_m;
% save tsp_small_struct_02172010 tsp_small_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups);
% tsp_struct(d).name = 'lung_cancer';
% tsp_struct(d).accuracy = results(5);
% save tsp_struct_02172010 tsp_struct
% 
% [h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
% svm_struct(d).name = 'lung_cancer';
% svm_struct(d).accuracy = results(1,5);
% svm_struct(d).accuracy2 = results(2,5);
% svm_struct(d).G_m = G_m;
% save svm_struct_02172010 svm_struct
% clear
% 
% 
% d=4
% load marfan_GDS2960
% load gs_definitions biocarta_gs_defs
% load eta_struct_02172010
% load tsp_small_struct_02172010
% load tsp_struct_02172010
% load svm_struct_02172010
% 
% if sum(sum(isnan(E_log10_QN)))
%     notnan = find(sum(isnan(E_log10_QN),2)==0);
%     names = names(notnan);
%     E_log10_QN = E_log10_QN(notnan,:);
% end
% 
% gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
% [eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
% G_m = eta_stats(1,2);
% 
% [classifiers,results] = eta_loocv(gs_struct,groups,1);
% eta_struct(d).name = 'marfan_syndrome';
% eta_struct(d).accuracy = results(5);
% save eta_struct_02172010 eta_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
% tsp_small_struct(d).name = 'marfan_syndrome';
% tsp_small_struct(d).accuracy = results(5);
% tsp_small_struct(d).G_m = G_m;
% save tsp_small_struct_02172010 tsp_small_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups);
% tsp_struct(d).name = 'marfan_syndrome';
% tsp_struct(d).accuracy = results(5);
% save tsp_struct_02172010 tsp_struct
% 
% [h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
% svm_struct(d).name = 'marfan_syndrome';
% svm_struct(d).accuracy = results(1,5);
% svm_struct(d).accuracy2 = results(2,5);
% svm_struct(d).G_m = G_m;
% save svm_struct_02172010 svm_struct
% clear
% 
% 
% d=5
% load crohns_GDS1615
% load gs_definitions biocarta_gs_defs
% load eta_struct_02172010
% load tsp_small_struct_02172010
% load tsp_struct_02172010
% load svm_struct_02172010
% 
% if sum(sum(isnan(E_log10_QN)))
%     notnan = find(sum(isnan(E_log10_QN),2)==0);
%     names = names(notnan);
%     E_log10_QN = E_log10_QN(notnan,:);
% end
% 
% gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
% [eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
% G_m = eta_stats(1,2);
% 
% [classifiers,results] = eta_loocv(gs_struct,groups,1);
% eta_struct(d).name = 'crohns_disease';
% eta_struct(d).accuracy = results(5);
% save eta_struct_02172010 eta_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
% tsp_small_struct(d).name = 'crohns_disease';
% tsp_small_struct(d).accuracy = results(5);
% tsp_small_struct(d).G_m = G_m;
% save tsp_small_struct_02172010 tsp_small_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups);
% tsp_struct(d).name = 'crohns_disease';
% tsp_struct(d).accuracy = results(5);
% save tsp_struct_02172010 tsp_struct
% 
% [h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
% svm_struct(d).name = 'crohns_disease';
% svm_struct(d).accuracy = results(1,5);
% svm_struct(d).accuracy2 = results(2,5);
% svm_struct(d).G_m = G_m;
% save svm_struct_02172010 svm_struct
% clear
% 
% 
% d=6
% load parkinsons_GDS2519
% load gs_definitions biocarta_gs_defs
% load eta_struct_02172010
% load tsp_small_struct_02172010
% load tsp_struct_02172010
% load svm_struct_02172010
% 
% if sum(sum(isnan(E_log10_QN)))
%     notnan = find(sum(isnan(E_log10_QN),2)==0);
%     names = names(notnan);
%     E_log10_QN = E_log10_QN(notnan,:);
% end
% 
% gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
% [eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
% G_m = eta_stats(1,2);
% 
% [classifiers,results] = eta_loocv(gs_struct,groups,1);
% eta_struct(d).name = 'parkinsons_disease';
% eta_struct(d).accuracy = results(5);
% save eta_struct_02172010 eta_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
% tsp_small_struct(d).name = 'parkinsons_disease';
% tsp_small_struct(d).accuracy = results(5);
% tsp_small_struct(d).G_m = G_m;
% save tsp_small_struct_02172010 tsp_small_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups);
% tsp_struct(d).name = 'parkinsons_disease';
% tsp_struct(d).accuracy = results(5);
% save tsp_struct_02172010 tsp_struct
% 
% [h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
% svm_struct(d).name = 'parkinsons_disease';
% svm_struct(d).accuracy = results(1,5);
% svm_struct(d).accuracy2 = results(2,5);
% svm_struct(d).G_m = G_m;
% save svm_struct_02172010 svm_struct
% clear
% 
% d=7
% load bipolar_GDS2190
% load gs_definitions biocarta_gs_defs
% load eta_struct_02172010
% load tsp_small_struct_02172010
% load tsp_struct_02172010
% load svm_struct_02172010
% 
% if sum(sum(isnan(E_log10_QN)))
%     notnan = find(sum(isnan(E_log10_QN),2)==0);
%     names = names(notnan);
%     E_log10_QN = E_log10_QN(notnan,:);
% end
% 
% gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
% [eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
% G_m = eta_stats(1,2);
% 
% [classifiers,results] = eta_loocv(gs_struct,groups,1);
% eta_struct(d).name = 'bipolar_disorder';
% eta_struct(d).accuracy = results(5);
% save eta_struct_02172010 eta_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
% tsp_small_struct(d).name = 'bipolar_disorder';
% tsp_small_struct(d).accuracy = results(5);
% tsp_small_struct(d).G_m = G_m;
% save tsp_small_struct_02172010 tsp_small_struct
% 
% [h_tsp,results] = tsp_loocv(E_log10_QN,groups);
% tsp_struct(d).name = 'bipolar_disorder';
% tsp_struct(d).accuracy = results(5);
% save tsp_struct_02172010 tsp_struct
% 
% [h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
% svm_struct(d).name = 'bipolar_disorder';
% svm_struct(d).accuracy = results(1,5);
% svm_struct(d).accuracy2 = results(2,5);
% svm_struct(d).G_m = G_m;
% save svm_struct_02172010 svm_struct
% clear


d=8
load leukemia_JHU
load gs_definitions biocarta_gs_defs
load eta_struct_02172010
load tsp_small_struct_02172010
load tsp_struct_02172010
load svm_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
G_m = eta_stats(1,2);

[classifiers,results] = eta_loocv(gs_struct,groups,1);
eta_struct(d).name = 'leukemia_JHU';
eta_struct(d).accuracy = results(5);
save eta_struct_02172010 eta_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
tsp_small_struct(d).name = 'leukemia_JHU';
tsp_small_struct(d).accuracy = results(5);
tsp_small_struct(d).G_m = G_m;
save tsp_small_struct_02172010 tsp_small_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups);
tsp_struct(d).name = 'leukemia_JHU';
tsp_struct(d).accuracy = results(5);
save tsp_struct_02172010 tsp_struct

[h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
svm_struct(d).name = 'leukemia_JHU';
svm_struct(d).accuracy = results(1,5);
svm_struct(d).accuracy2 = results(2,5);
svm_struct(d).G_m = G_m;
save svm_struct_02172010 svm_struct
clear


d=9
load leukemia_GSEA
load gs_definitions biocarta_gs_defs
load eta_struct_02172010
load tsp_small_struct_02172010
load tsp_struct_02172010
load svm_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
G_m = eta_stats(1,2);

[classifiers,results] = eta_loocv(gs_struct,groups,1);
eta_struct(d).name = 'leukemia_GSEA';
eta_struct(d).accuracy = results(5);
save eta_struct_02172010 eta_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
tsp_small_struct(d).name = 'leukemia_GSEA';
tsp_small_struct(d).accuracy = results(5);
tsp_small_struct(d).G_m = G_m;
save tsp_small_struct_02172010 tsp_small_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups);
tsp_struct(d).name = 'leukemia_GSEA';
tsp_struct(d).accuracy = results(5);
save tsp_struct_02172010 tsp_struct

[h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
svm_struct(d).name = 'leukemia_GSEA';
svm_struct(d).accuracy = results(1,5);
svm_struct(d).accuracy2 = results(2,5);
svm_struct(d).G_m = G_m;
save svm_struct_02172010 svm_struct
clear


d=10
load squamous_GDS2520
load gs_definitions biocarta_gs_defs
load eta_struct_02172010
load tsp_small_struct_02172010
load tsp_struct_02172010
load svm_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
G_m = eta_stats(1,2);

[classifiers,results] = eta_loocv(gs_struct,groups,1);
eta_struct(d).name = 'squamous_carcinoma';
eta_struct(d).accuracy = results(5);
save eta_struct_02172010 eta_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
tsp_small_struct(d).name = 'squamous_carcinoma';
tsp_small_struct(d).accuracy = results(5);
tsp_small_struct(d).G_m = G_m;
save tsp_small_struct_02172010 tsp_small_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups);
tsp_struct(d).name = 'squamous_carcinoma';
tsp_struct(d).accuracy = results(5);
save tsp_struct_02172010 tsp_struct

[h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
svm_struct(d).name = 'squamous_carcinoma';
svm_struct(d).accuracy = results(1,5);
svm_struct(d).accuracy2 = results(2,5);
svm_struct(d).G_m = G_m;
save svm_struct_02172010 svm_struct
clear


d=11
load ovary_GDS2785
load gs_definitions biocarta_gs_defs
load eta_struct_02172010
load tsp_small_struct_02172010
load tsp_struct_02172010
load svm_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
G_m = eta_stats(1,2);

[classifiers,results] = eta_loocv(gs_struct,groups,1);
eta_struct(d).name = 'ovarian_cancer';
eta_struct(d).accuracy = results(5);
save eta_struct_02172010 eta_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
tsp_small_struct(d).name = 'ovarian_cancer';
tsp_small_struct(d).accuracy = results(5);
tsp_small_struct(d).G_m = G_m;
save tsp_small_struct_02172010 tsp_small_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups);
tsp_struct(d).name = 'ovarian_cancer';
tsp_struct(d).accuracy = results(5);
save tsp_struct_02172010 tsp_struct

[h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
svm_struct(d).name = 'ovarian_cancer';
svm_struct(d).accuracy = results(1,5);
svm_struct(d).accuracy2 = results(2,5);
svm_struct(d).G_m = G_m;
save svm_struct_02172010 svm_struct
clear


d=12
load prostate_GDS2545_p_nf
load gs_definitions biocarta_gs_defs
load eta_struct_02172010
load tsp_small_struct_02172010
load tsp_struct_02172010
load svm_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
G_m = eta_stats(1,2);

[classifiers,results] = eta_loocv(gs_struct,groups,1);
eta_struct(d).name = 'prostate_cancer';
eta_struct(d).accuracy = results(5);
save eta_struct_02172010 eta_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
tsp_small_struct(d).name = 'prostate_cancer';
tsp_small_struct(d).accuracy = results(5);
tsp_small_struct(d).G_m = G_m;
save tsp_small_struct_02172010 tsp_small_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups);
tsp_struct(d).name = 'prostate_cancer';
tsp_struct(d).accuracy = results(5);
save tsp_struct_02172010 tsp_struct

[h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
svm_struct(d).name = 'prostate_cancer';
svm_struct(d).accuracy = results(1,5);
svm_struct(d).accuracy2 = results(2,5);
svm_struct(d).G_m = G_m;
save svm_struct_02172010 svm_struct
clear


d=13
load prostate_GDS2545_m_nf
load gs_definitions biocarta_gs_defs
load eta_struct_02172010
load tsp_small_struct_02172010
load tsp_struct_02172010
load svm_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
G_m = eta_stats(1,2);

[classifiers,results] = eta_loocv(gs_struct,groups,1);
eta_struct(d).name = 'metastatic_prostate_cancer';
eta_struct(d).accuracy = results(5);
save eta_struct_02172010 eta_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
tsp_small_struct(d).name = 'metastatic_prostate_cancer';
tsp_small_struct(d).accuracy = results(5);
tsp_small_struct(d).G_m = G_m;
save tsp_small_struct_02172010 tsp_small_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups);
tsp_struct(d).name = 'metastatic_prostate_cancer';
tsp_struct(d).accuracy = results(5);
save tsp_struct_02172010 tsp_struct

[h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
svm_struct(d).name = 'metastatic_prostate_cancer';
svm_struct(d).accuracy = results(1,5);
svm_struct(d).accuracy2 = results(2,5);
svm_struct(d).G_m = G_m;
save svm_struct_02172010 svm_struct
clear


d=14
load prostate_GDS2545_m_p
load gs_definitions biocarta_gs_defs
load eta_struct_02172010
load tsp_small_struct_02172010
load tsp_struct_02172010
load svm_struct_02172010

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
G_m = eta_stats(1,2);

[classifiers,results] = eta_loocv(gs_struct,groups,1);
eta_struct(d).name = 'prostate_cancer_progression';
eta_struct(d).accuracy = results(5);
save eta_struct_02172010 eta_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups,G_m);
tsp_small_struct(d).name = 'prostate_cancer_progression';
tsp_small_struct(d).accuracy = results(5);
tsp_small_struct(d).G_m = G_m;
save tsp_small_struct_02172010 tsp_small_struct

[h_tsp,results] = tsp_loocv(E_log10_QN,groups);
tsp_struct(d).name = 'prostate_cancer_progression';
tsp_struct(d).accuracy = results(5);
save tsp_struct_02172010 tsp_struct

[h_svm,h_svm2,results] = svm_loocv(E_log10_QN,groups,G_m);
svm_struct(d).name = 'prostate_cancer_progression';
svm_struct(d).accuracy = results(1,5);
svm_struct(d).accuracy2 = results(2,5);
svm_struct(d).G_m = G_m;
save svm_struct_02172010 svm_struct
clear
