clear
close all

blue = [198,217,241]/255; dark_blue = [31,73,125]/255;
yellow = [255,192,0]/255;
red = [255,0,0]/255; dark_red = [192,0,0]/255;
olive = [119,147,60]/255;
brown = [221,217,195]/255;


cd 'Datasets\Prostate (GDS2545)'
load prostate_GDS2545_m_nf
cd ../..
% load prostate_GDS2545_m_nf
% load prostate_GDS2545_m_p
load lc_gs_defs prostate_GDS2545_m_nf_lc_gs_defs
biocarta_gs_defs = prostate_GDS2545_m_nf_lc_gs_defs;

load lc_eta_struct_prostate
eta_stats = eta_struct(2).stats;

cd Co're Functions'\

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

N = numel(groups);
N_1 = sum(groups); N_2 = sum(~groups);

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
X = gs_struct.X;
g_gs_idx = gs_struct.g_gs_idx;

[R_1,R_2] = rank_matching(X,g_gs_idx,'train',groups);
Delta = R_1-R_2;

Delta_s = Delta(eta_stats(:,1),:);

Delta_1 = Delta_s(:,groups);
[Delta_top_1,s1] = sort(Delta_1(1,:),'descend');
Delta_1 = Delta_1(:,s1);

Delta_2 = Delta_s(:,~groups);
[Delta_top_2,s2] = sort(Delta_2(1,:),'descend');
Delta_2 = Delta_2(:,s2);

Delta_s = [Delta_1,Delta_2];
 
subplot('position',[0.05,.05,.9,.85])

clims = [min(min(Delta_s)),max(max(Delta_s))];
imagesc(Delta_s,clims)

% make colormap
scale1 = flipud(1-exp(-0.1*[0:31])'); scale1 = scale1/max(scale1);
r1 = yellow(1)*scale1; g1 = yellow(2)*scale1; b1 = yellow(3)*scale1;
rgb1 = [r1,g1,b1];
scale2 = 1-exp(-0.1*[0:31])'; scale2 = scale2/max(scale2);
r2 = blue(1)*scale2; g2 = blue(2)*scale2; b2 = blue(3)*scale2;
rgb2 = [r2,g2,b2];
rgb = [rgb1;rgb2];

colormap(rgb)
% xlabel('Samples','fontsize',8)
ylabel('Networks','fontsize',8)

text(N_1/2,-6,'metastatic samples',...
    'horizontalalignment','center',...
    'fontsize',8,'fontweight','bold')

text(N_1+N_2/2,-6,'normal samples',...
    'horizontalalignment','center',...
    'fontsize',8,'fontweight','bold')

% text(37.5,-16,'Rank difference scores in GIST/LMS',...
%     'horizontalalignment','center',...
%     'fontsize',9,'fontweight','bold')

set(gca,'xtick',[],'ytick',[],'fontsize',8)
colorbar
set(gca,'fontsize',8)


 