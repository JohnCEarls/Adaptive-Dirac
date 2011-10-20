% function make_lc_gs_defs_mat()


% read communities generated for each dataset
cd 'comm_data\sorted';
dirlist = dir('.');
for i=3:length(dirlist)
    % skip '.' and '..'
    files(i-2) = fopen(dirlist(i).name, 'r');
    % add name of dataset with prefix and suffix trimmed
    names{i-2} = dirlist(i).name(7:length(dirlist(i).name)-41);
end
cd '../../';

files(1) = fopen('sorted_hprd_edges_maxS0.215385_maxD0.042220.comm2nodes.txt','r')
names{1} = 'hprd_lc'

% create mat file containing all networks for each dataset in gs defs format
for i=1:length(files)
    % only read at most 1000 networks for a given dataset
    % or stop when the networks begin to have < 5 genes each
    count = 1;
    line = fgetl(files(i));
    if length(strfind(line, '-')) == 0
        network = regexp(line, '\t', 'split');
        maxnum = str2double(network{1});
        network = network(2:length(network));
        prepend{1} = strcat(num2str(count), '_', names{i});
        prepend{2} = 'na';
        networks = cell(250, maxnum+2);
        networks(count,:) = {prepend{:}, network{:}};
    else
        line = fgetl(files(i));
        while length(strfind(line, '-'))
            line = fgetl(files(i));
        end
        network = regexp(line, '\t', 'split');
        maxnum = str2double(network{1});
        network = network(2:length(network));
        prepend{1} = strcat(num2str(count), '_', names{i});
        prepend{2} = 'na';
        networks = cell(250, maxnum+2);
        networks(count,:) = {prepend{:}, network{:}};
    end
    while line ~= -1
        line = fgetl(files(i));
        if length(strfind(line, '-')) == 0
            count = count + 1;
            network = regexp(line, '\t', 'split');
            numgenes = str2double(network{1});
            network = network(2:length(network));
            prepend{1} = strcat(num2str(count), '_', names{i});
            buffer = cell(1, maxnum-numgenes);
            networks(count,:) = {prepend{:}, network{:}, buffer{:}};
            if numgenes < 5
                disp 'Finished, hit threshold for network size (<5 genes) on dataset:'
                disp(names{i})
                break
            else if count > 1000
                disp 'Finished, hit threshold for number of networks/dataset (1000) on dataset:'
                disp(names{i})
                break
                end
            end        
        end
    end
    networks = networks(1:count,:);
    assignin('base', strcat(names{i}, '_lc_gs_defs'),  networks);
    if i > 1
        save('./lc_gs_defs.mat', strcat(names{i},'_lc_gs_defs'), '-append')
    else save('./lc_gs_defs.mat', strcat(names{i},'_lc_gs_defs'))
    end
    fclose(files(i));
end

