function [ ] = reformat( dataset )
%REFORMAT Summary of this function goes here
%   reads in a dataset name/path as a string
%   writes out a txt file of gene names to the same dir

names = load(dataset, 'names');
names_new = load(dataset, 'names_new');
names = names.names;
names_new = names_new.names_new;

% get rid of the .m and append .txt
fname = strcat(dataset(1:length(dataset)-4), '.txt');

f = fopen(fname, 'w');

for i=1:length(names)
%    if strcmp(names{i}, names_new{i})
%        fprintf(f, '%s\n', names{i});
%    else
%        fprintf(f, '%s, %s\n', names{i}, names_new{i});
%    end
	fprintf(f, '%s\n', names{i});

end

fclose(f);
     