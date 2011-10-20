% accuracy_plots
% close all

blue = [198,217,241]/255; dark_blue = [31,73,125]/255;
yellow = [255,192,0]/255;
dark_red = [192,0,0]/255;
olive = [119,147,60]/255;
% brown = [221,217,195]/255;
brown = [255,255,255]/255;
gray = [225,225,225]/255;


d_names = {{'GIST';'vs.';'LMS'},...
    {'(nr) breast cancer';'vs.';'(r) breast cancer'},...
    {'lung cancer';'vs.';'normal lung'},...
    {'MFS fibroblast';'vs.';'non-MFS fibroblast'},...
    {'Crohn''s PBMCs';'vs.';'non-Crohn''s PBMCs'},...
    {'Parkinson''s disease';'vs.';'healthy blood'},...
    {'bipolar cortex';'vs.';'non-bipolar cortex'},...
    {'AML 1';'vs.';'ALL 1'},...
    {'AML 2';'vs.';'ALL 2'},...
    {'HNSCC';'vs.';'normal head/neck'},...
    {'CL ovarian tumor';'vs.';'AL ovarian tumor'},...
    {'(p) prostate cancer';'vs.';'normal prostate'},...
    {'(m) prostate cancer';'vs.';'normal prostate'},...
    {'(m) prostate cancer';'vs.';'(p) prostate cancer'}};
d_names([3,5,6]) = [];

sort_order = [1;8;3;7;2;4;5;6;9;10;11];
d_names = d_names(sort_order);

load eta_struct_02172010
[a{1:numel(eta_struct)}] = deal(eta_struct.accuracy);
DIRAC = 100*cell2mat(a);
DIRAC([3,5,6]) = [];
DIRAC = DIRAC(sort_order);

% load tsp_struct_02102010
% [a{1:numel(tsp_struct)}] = deal(tsp_struct.accuracy);
% TSP = 100*cell2mat(a);
% TSP([3,5,6]) = [];

load tsp_small_struct_02172010
[a{1:numel(tsp_small_struct)}] = deal(tsp_small_struct.accuracy);
TSP = 100*cell2mat(a);
TSP([3,5,6]) = [];
TSP = TSP(sort_order);

load svm_struct_02172010
[a{1:numel(svm_struct)}] = deal(svm_struct.accuracy);
SVM = 100*cell2mat(a);
SVM([3,5,6]) = [];
SVM = SVM(sort_order);


r = [DIRAC;TSP;SVM]';
[m,n] = size(r);
m = [0,2,5,8,m];
n = n+1;

colors = {dark_blue,brown,yellow};


% subplot('position',[0.1 0.6 0.85 .35])
figure;
subplot(4,1,1)
x = m(1)+1:m(2);
for j = 1:n-1
    bar(x+(j-2)/n,r(m(1)+1:m(2),j),1/n,...
        'facecolor',colors{j})
    hold on
end
for i = 1:numel(x)
    text(x(i)-1/n,r(x(i),1)+10,num2str(r(x(i),1),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i),r(x(i),2)+10,num2str(r(x(i),2),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i)+1/n,r(x(i),3)+10,num2str(r(x(i),3),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i),-2,d_names{x(i)},'fontsize',7,...
        'verticalalignment','top','horizontalalignment','center')
end
    
legend('DIRAC','TSP','SVM',...
    'orientation','vertical','location','eastoutside')
% title('Cross validation accuracies','fontsize',8)
xlim([0.45 2.55])
ylim([0 140])
% ylabel('Cross validation accuracy')
set(gca,'xtick',[],'ytick',[],'fontsize',8)

% subplot('position',[0.1 0.1 0.85 0.35])
subplot(4,1,2)
x = m(2)+1:m(3);
for j = 1:n-1
    bar(x+(j-2)/n,r(m(2)+1:m(3),j),1/n,...
        'facecolor',colors{j})
    hold on
end
for i = 1:numel(x)
    text(x(i)-1/n,r(x(i),1)+10,num2str(r(x(i),1),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i),r(x(i),2)+10,num2str(r(x(i),2),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i)+1/n,r(x(i),3)+10,num2str(r(x(i),3),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i),-2,d_names{x(i)},'fontsize',7,...
        'verticalalignment','top','horizontalalignment','center')
end

xlim([2.45 5.55])
ylim([0 140])
ylabel('Cross validation accuracy','fontsize',8)
set(gca,'xtick',[],'ytick',[],'fontsize',8)

subplot(4,1,3)
x = m(3)+1:m(4);
for j = 1:n-1
    bar(x+(j-2)/n,r(m(3)+1:m(4),j),1/n,...
        'facecolor',colors{j})
    hold on
end
for i = 1:numel(x)
    text(x(i)-1/n,r(x(i),1)+10,num2str(r(x(i),1),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i),r(x(i),2)+10,num2str(r(x(i),2),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i)+1/n,r(x(i),3)+10,num2str(r(x(i),3),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i),-2,d_names{x(i)},'fontsize',7,...
        'verticalalignment','top','horizontalalignment','center')
end

xlim([5.45 8.55])
ylim([0 140])
ylabel('Cross validation accuracy')
set(gca,'xtick',[],'ytick',[],'fontsize',8)


subplot(4,1,4)
x = m(4)+1:m(5);
for j = 1:n-1
    bar(x+(j-2)/n,r(m(4)+1:m(5),j),1/n,...
        'facecolor',colors{j})
    hold on
end
for i = 1:numel(x)
    text(x(i)-1/n,r(x(i),1)+10,num2str(r(x(i),1),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i),r(x(i),2)+10,num2str(r(x(i),2),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i)+1/n,r(x(i),3)+10,num2str(r(x(i),3),'%3.1f'),...
        'horizontalalignment','center','fontsize',7)
    text(x(i),-2,d_names{x(i)},'fontsize',7,...
        'verticalalignment','top','horizontalalignment','center')
end

xlim([8.45 11.55])
ylim([0 140])
% ylabel('Cross validation accuracy')
set(gca,'xtick',[],'ytick',[],'fontsize',8)

% subplot(5,1,5)
% x = m(5)+1:m(6);
% for j = 1:n-1
%     bar(x+(j-2)/n,r(m(5)+1:m(6),j),1/n,...
%         'facecolor',colors{j})
%     hold on
% end
% for i = 1:numel(x)
%     text(x(i)-1/n,r(x(i),1)+10,num2str(r(x(i),1),'%3.1f'),...
%         'horizontalalignment','center','fontsize',7)
%     text(x(i),r(x(i),2)+10,num2str(r(x(i),2),'%3.1f'),...
%         'horizontalalignment','center','fontsize',7)
%     text(x(i)+1/n,r(x(i),3)+10,num2str(r(x(i),3),'%3.1f'),...
%         'horizontalalignment','center','fontsize',7)
%     text(x(i),-2,d_names{x(i)},'fontsize',7,...
%         'verticalalignment','top','horizontalalignment','center')
% end
% 
% xlim([11.45 14.55])
% ylim([0 140])
% % ylabel('Cross validation accuracy')
% set(gca,'xtick',[],'ytick',[],'fontsize',8)
