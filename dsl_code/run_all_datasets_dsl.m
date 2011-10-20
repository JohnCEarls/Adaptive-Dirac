function run_all_datasets_dsl

NUM_BIOCARTA_NETWORKS = 248;  %lose 1 network, eta_gs_start only has 248 from 249
NUM_HPRD_LC_NETWORKS = 763;   %lose 14 networks, eta_gs_start only has 763 from 777


datasets = {
%    'Bipolar Disorder (GDS2190)/', 'bipolar_GDS2190', 'bipolar';...    
%    'Breast Cancer (GDS807)/', 'breast_GDS807', 'breast';...
%    'Crohn''s Disease (GDS1615)/', 'crohns_GDS1615', 'crohns';...
%    'Gastro. Sarcoma (MDAnderson)/', 'sarcoma_data', 'gastro_sarcoma';...
%    'Leukemia (GSEA)/', 'leukemia_GSEA', 'leukemia_gsea';...    
    % this dataset is formatted oddly
    %'Leukemia (JHU)/', 'leukemia_JHU', 'leukemia_jhu';...
    'Lung Cancer (GDS2771)/', 'lung_GDS2771', 'lung';...
    'Marfan Syndrome (GDS2960)/', 'marfan_GDS2960', 'marfan';...
    'Melanoma (GDS2735)/', 'melanoma_GDS2735', 'melanoma';...
    'Ovarian Cancer (GDS2785)/', 'ovary_GDS2785', 'ovary';...    
    'Parkinson''s (GDS2519)/', 'parkinsons_GDS2519', 'parkinsons';...
    %(3 classes in prostate)
    'Sarcoma (GDS1209)/', 'sarcoma_GDS1209', 'sarcoma';...
    'Squamous Carcinoma (GDS2520)/', 'squamous_GDS2520', 'sq_carcinoma'
    };
    
if not(isdir('dsl_results'))
    mkdir dsl_results
end

is_extended_ppi = false;       % use the 2-edge extended ppi graph
is_biocarta = true;         % use the biocarta or LC networks as seeds
num_networks = 50;            % number of networks to find/learn
num_iterations = 50;         % full iterations of sffs to perform
num_fdr_permuts = 100;       % number of null hypothesis permutations to do
num_folds = 10;            % divide the sample into how many folds for CV testing
eta_cutoff = 0.01;           % sffs ending iteration criteria for eta upper-bound
jaccard_cutoff = 0.0;       % "" for jaccard similarity lower-bound


num_sffs_fdr_permuts = 1;    % do not need to check for p-val while iterating sffs

id_str = [int2str(num_networks) 'n' int2str(num_iterations) 'i' ...
    int2str(num_fdr_permuts) 'p' int2str(num_folds * 100) 'f' ...
    int2str(eta_cutoff * 100) 'e' int2str(jaccard_cutoff * 100) 'j'];

if is_extended_ppi
    id_str = ['2e_' id_str]
end
  
if is_biocarta
    disp(['Running... (biocarta networks) ' id_str])    
    num_networks = min(num_networks, NUM_BIOCARTA_NETWORKS);    
else
    disp(['Running... (lc networks) ' id_str])
    num_networks = min(num_networks, NUM_HPRD_LC_NETWORKS);    
end

for d = 1:size(datasets,1)
    tic
    if not(isdir(strcat('dsl_results/',datasets{d,3})))
        mkdir(strcat('dsl_results/',datasets{d,3}));
    end

    cd './Datasets';
    load(strcat(datasets{d,1}, datasets{d,2}));
    
    if sum(sum(isnan(E_log10_QN)))
        notnan = find(sum(isnan(E_log10_QN),2)==0);
        names = names(notnan);
        E_log10_QN = E_log10_QN(notnan,:);
    end
    
    if not(exist('names_new', 'var'))
        names_new = names;
    end
    
    cd '../Core Functions'
    
    disp '==========================';
    disp(datasets{d,3});
    disp ' ';
    
    dsl_on_dataset(E_log10_QN, groups, names_new, datasets(d,3),...
        num_networks, num_iterations, num_fdr_permuts, num_sffs_fdr_permuts, ...
        num_folds, is_biocarta, eta_cutoff, jaccard_cutoff, is_extended_ppi);
    
    cd '..'
    toc
end

disp ''
if is_biocarta
    disp(['Finished (biocarta networks) ' id_str])    
    load gs_definitions biocarta_gs_defs
    gs_defs = biocarta_gs_defs;
else
    disp(['Finished (lc networks) ' id_str])
    load hprd_lc_gs_defs
    gs_defs = hprd_lc_gs_defs;
end
