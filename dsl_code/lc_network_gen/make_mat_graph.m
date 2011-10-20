%% makes a graph out of the existing edge list txt file
% representation done as a struct (hash table) where fields index gene
% symbols, mapping to the adjacent nodes.
% ppi.('brca1') = {'brca1' 'rad51' 'brca2'}

cd files_used\
f = fopen('hprd_edges.txt', 'r');

ppi = {};

line = fgetl(f);
while line ~= -1
    line = strrep(line, '-', '_');
    line = strrep(line, '@', 'atsign');
    line = regexp(line, '\t', 'split');

    if strcmp(line{1}, '_') || strcmp(line{2}, '_')
        line = fgetl(f);
        continue
    else
       if isfield(ppi, line{1})
           ppi.(line{1}) = [ppi.(line{1}) {line{2}}];
       else
           ppi.(line{1}) = {line{2}};
       end    
       if strcmp(line{1}, line{2}) == 0
           if isfield(ppi, line{2})
               ppi.(line{2}) = [ppi.(line{2}) {line{1}}];
           else
               ppi.(line{2}) = {line{1}};
           end 
       end
    end
    line = fgetl(f);
end

save hprd_ppi_graph ppi

cd ..