function supersets = generate_neighbor_supersets(ppi, original, E_log10_QN, names_new)

already_included = java.util.Hashtable;

supersets = {};
name = original{1};
if strcmp(original{2}, 'na')
    pathroot = '';
else
    pathroot = original{2};
end

for count=3:length(original)
   if isempty(original{count})
       original = original(1:count-1);
       break
   else
       already_included.put(original{count}, 1);
   end
end
original = original(3:end);

% consider each set of neighbors
for i=1:length(original)
    fieldname = original{i};
    if ~isfield(ppi, fieldname)
        continue;
    end
    neighbors = ppi.(fieldname);
    % only consider neighbors to add with actual expression values
    gs_neighbors = gs_match_id(E_log10_QN, names_new, ['name','id',neighbors]);
    for j=1:length(gs_neighbors.g_gs)
        fieldname = gs_neighbors.g_gs{j};
        if isempty(fieldname)
            break;
        end
        if already_included.containsKey(fieldname)
            continue
        else
            path = strcat(pathroot, '+',gs_neighbors.g_gs{j});
            supersets = [supersets; [name, path, original, {gs_neighbors.g_gs{j}}]];
            already_included.put(fieldname, 1);
        end
    end
end