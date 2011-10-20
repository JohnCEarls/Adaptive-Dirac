function extended = extend_ppi(ppi)

extended = struct();
fields = fieldnames(ppi);

% cycle through each interactor in the network
for j=1:length(fields)
    
  % track interactions already included
  included = java.util.Hashtable;

  % interactor we are interested in
  p = fields{j};
  % these were the previous interactions
  extended.(p) = ppi.(p);
  for k=1:length(extended.(p))
    included.put(extended.(p){k},1);
  end
    
  % cycle through each of the previous interactions
  for k=1:length(ppi.(p))
      
    % these are the interacting protein's other interactors
    extension = ppi.(ppi.(p){k});
    % add each of the other interactors to p's list unless already in
    for h=1:length(extension)
      if included.containsKey(extension{h})
        continue
      else
        included.put(extension{h}, 1);
        extended.(p) = [extended.(p), extension{h}];
      end
    end
  end

end


