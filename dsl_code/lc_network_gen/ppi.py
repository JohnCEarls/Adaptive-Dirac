# Utilities for creating/manipulating protein-protein interaction graphs
# File: ppi.py
# Author: Bobak Hadidi
# Date: 3/18/10

import os
import cPickle
import pygraphviz as pgv

def draw_graph(fname, nodes, ppi, small=False):
  nodes = list(set(nodes))
  g = pgv.AGraph()
  for node in nodes:
    if node in ppi.keys():
      adjacent = ppi[node].intersection(set(nodes))     
      for adj in list(adjacent):
        g.add_edge(node, adj)
    else:
      continue
  if(not small):
    g.draw(fname+'_fdp.jpg', prog='fdp')
  else: # for smaller graphs
    g.draw(fname+'_neato.jpg', prog='neato')
    g.draw(fname+'_twopi.jpg', prog='twopi')

def combine_ppi_graphs():
  try:
    f = open('bg_dip_hprd_ppi', 'r')
    return cPickle.load(f)
  except IOError:
    biogrid = make_biogrid_ppi_graph()
    hprd = make_hprd_ppi_graph()
    dip = make_dip_ppi_graph()

    comb = biogrid
    for key in hprd.keys():
      if(key in comb.keys()):
        comb[key] = comb[key].union(hprd[key])
      else:
        comb[key] = hprd[key]
    for key in dip.keys():
      if(key in comb.keys()):
        comb[key] = comb[key].union(dip[key])
      else:
        comb[key] = dip[key]
    cPickle.dump(comb, open('bg_dip_hprd_ppi', 'w'))
    return comb

def read_biocarta_gs(fname='biocarta_gs.txt', path='./'):
  '''
  Returns the set of gene sets defined by biocarta (a dict from pathway name -> set)
  default path+fname is ./biocarta_gs.txt
  '''
  try:
    f = open(path+fname, 'r')
  except IOError:
    print 'Error: could not open file \'%s\' to make gene set set\n' % path+fname
    return None
  
  all = {}
  for line in f:
    line = line.strip().split(' ')
    name = line[0]
    network = set()
    for gene in line[2:]: # skip the name and 'na'
      network.add(gene.strip())
    all[name] = network
  return all

def read_lc_gs(fname='edges_prostate_GDS2545_m_nf_maxS0.209677_maxD0.049310.comm2nodes.txt', path='./comm_data/sorted/'):
  '''
  returns the set of gene sets defined by the lc algorithm (a dict from # -> set)
  default path is ./comm_data/sorted
  '''
  try:
    f = open(path+fname, 'r')
  except IOError:
    print 'Error: could not open file \'%s\' to make gene set set\n' % (path+fname)
    return None
  
  all = {}
  for i, line in enumerate(f):
    line = line.split('\t')
    count = int(line[0])
    comm = set()
    for gene in line[1:]:
      comm.add(gene.strip())
    all[i+1] = comm
  return all

# O(n*m) algorithm compare each set in biocarta gs defs to lc gs defs
def map_sets(biocarta, linkcomm, threshold=.10, jaccard=True):
  '''
  _returns a mapping from the biocarta sets to a list of 3-tuples (jcoeff, lc geneset, lc-key)
  and a mapping from the lc sets to a list of 3-tuples (jcoeff, bc geneset, bc-key)
  for a given biocarta geneset, its list will contain all lc-defined networks
  with associated jaccard coefficient above the certain threshold
  '''
  total = len(biocarta)
  bmappingl = {} # from bc ->lc
  lmappingb = {} # from lc -> bc
  for i, name in enumerate(biocarta.keys()):
    bmappingl[name] = []
    gs = biocarta[name]
    for key in linkcomm.keys():
      lc = linkcomm[key]
      if jaccard: # use jaccard coefficient
        coeff = jaccard_coeff(gs, lc)
      else: # use subset coeff
        coeff = subset_coeff(gs, lc)
      if coeff < threshold:
        pass
      else:
        bmappingl[name].append((coeff, list(lc), key))
        if lmappingb.has_key(key):
          lmappingb[key].append((coeff, list(gs), name))
        else:
          lmappingb[key] = [(coeff, list(gs), name)]
    print 'Finished %.2f %%' % (100*float(i)/total)
  # sort each mapping from highest coeff to lowest
  for tupl in bmappingl.values():
    tupl.sort(__sort_coeff_subsets_helper__)
  for tupl in lmappingb.values():
    tupl.sort(__sort_coeff_subsets_helper__)
  return bmappingl, lmappingb 

def jaccard_coeff(a, b):
  '''
  Returns the jaccard coefficient between two sets
  '''
  inter = len(a.intersection(b))
  union = len(a.union(b))
  if union == 0:
    return -1.0
  else:
    return float(inter)/union

def subset_coeff(gs, lc):
  '''
  Returns the subset coeffcient b/w two sets
  defined as s = |A intersection B| / |smaller(A, B)|
  '''
  inter = len(gs.intersection(lc))
  size_gs = len(gs)
  size_lc = len(lc)
  if size_gs < size_lc:
    denom = size_gs
  else:
    denom = size_lc
  if denom == 0:
    return -1.0
  else:
    return float(inter)/denom

def __sort_coeff_subsets_helper__(pairone, pairtwo):
  '''
  pairone and pairtwo: (jcoeef, gene set as list)
  returns -1 if coeff_one >= coeff_two, 1 otherwise
  '''
  if pairone[0] >= pairtwo[0]:
    return -1
  else:
    return 1

def write_all_edgelists():
  '''
  Writes out an edgelist to ./edge_data/ for each dataset in ./txt_data/
  '''
  data = os.walk('./txt_data')
  data = data.next() #data is a generator object

  data = data[2] #only look at the files not dirs
  ppi = make_hprd_ppi_graph()
  for fname in data:
    print 'Starting on edgelist for '+fname+'\n'
    write_edgelist(fname, './txt_data/', ppi=ppi)

def write_edgelist(filename='bipolar_GDS2190.txt', path='', ppi=None):
  '''
  fileName: a file name or file obj which contains newline delimited GeneIDs
  Returns 1 if successfully wrote out edgelist to \'edges_FILENAME\'
  and 0 otherwise\n'
  '''
  #read the set of genes
  g = make_node_set(filename, path)
  #get known interactions as adjlist (a dict)
  if ppi is None:
    ppi = make_hprd_ppi_graph()
  #get relevant interactions as adjlist (a dict)
  gp = intersect_ppi_graph(g, ppi)
  #convert adjlist to edgelist (a set)
  edges = convert_adj_to_edgelist(gp)

  edgelist = list(edges)
  edgelist.sort()
  f = open('./edge_data/'+'edges_'+filename, 'w')
  for a,b in edgelist:
    f.write(a + '\t' + b + '\n')
  f.close()  

def make_node_set(filename='bipolar_GDS2190.txt', path=''):
  '''
  fileName: a file name or file obj which contains newline delimited GeneIDs
  Returns a set containing unique GeneIDs
  '''
  if type(filename) == str:
    try:
      f = open(path+filename, 'r')
    except IOError:
      print 'Error: could not open file \'%s\' to make node set\n' % filename
      return None
  elif type(filename) != file:
    print 'Error: make_node_set arg must be filename as str or file obj\n'
    return None

  geneSet = set()
  for line in f:
    geneSet.add(line[0:-1]) #truncate the \n, i.e. strip()
  return geneSet

def make_biogrid_ppi_graph():
  '''
  Interactions defined by the dataset 'BIOGRID_human_ppi.txt'
  Retuns a graph as an adjlist as a dict of (strs) GeneID's -> GeneID set
  '''
  try:
    f = open('BIOGRID_human_ppi.txt', 'r')
  except IOError:
    print 'Error: could not find \'BIOGRID_human_ppi.txt\'\
      dataset for creating PPI graph\n'
    return None

  ppiGraph = {}
  for line in f:
    l = line.split('\t')
    first = l[2]
    second = l[3]
    synonyms_first = l[4].split('|') + [first]
    synonyms_second = l[5].split('|') + [second]
    for a in synonyms_first:
      for b in synonyms_second:
        if ppiGraph.__contains__(a):
          ppiGraph[a].add(b)
        else:
          ppiGraph[a] = set()
          ppiGraph[a].add(b)
        if ppiGraph.__contains__(b):
          ppiGraph[b].add(a)
        else:
          ppiGraph[b] = set()
          ppiGraph[b].add(a)

  return ppiGraph
 
def make_dip_ppi_graph():
  '''
  Interactions defined by the dataset 'DIP_human_ppi.txt'
  Returns a graph as an adjlist as a dict of (strs) GeneID's -> GeneID set
  Requires lookup of uniprotID -> geneSymbol by pickled dict 'uniprotID_to_geneName'
  '''
  try:
    f = open('DIP_human_ppi.txt', 'r')
  except IOError:
    print 'Error: could not find \'DIP_human_ppi.txt\'\
      dataset for creating PPI graph\n'
    return None
  try:
    id2gn = cPickle.load(open('uniprotID_to_geneName', 'r'))
  except IOError:
    print 'Error: could not find \'uniprotID_to_geneName\'\
      pickled file for uniprotID -> gene symbool lookup'
    return None
  
  ppiGraph = {}
  for line in f:
    l = line.split('\t')
    first = l[0].split('|')
    second = l[1].split('|')
    first = __extract_uniprotIDs__(first)
    second = __extract_uniprotIDs__(second)
    first = __convert_id2gn__(first, id2gn)
    second = __convert_id2gn__(second, id2gn)
    if(len(first) != 0 and len(second) != 0):
      for a in first:
        for b in second:
          if ppiGraph.__contains__(a):
            ppiGraph[a].add(b)
          else:
            ppiGraph[a] = set()
            ppiGraph[a].add(b)
          if ppiGraph.__contains__(b):
            ppiGraph[b].add(a)
          else:
            ppiGraph[b] = set()
            ppiGraph[b].add(a)

  return ppiGraph
 
def __extract_uniprotIDs__(lst):
  retVal = []
  for e in lst:
    e = e.split(':')
    if(len(e) == 1):
      continue
    elif(e[0].strip() == 'uniprotkb'):
      retVal.append(e[1].strip())
  return retVal

def __convert_id2gn__(lst, id2gn):
  retVal = []
  for e in lst:
    if(e in id2gn.keys()):
      retVal.extend(list(id2gn[e]))
  return retVal

def make_hprd_ppi_graph():
  '''
  Interactions defined by the dataset 'HPRD_human_ppi.txt'
  Retuns a graph as an adjlist as a dict of (strs) GeneID's -> GeneID set
  '''
  try:
    f = open('HPRD_human_ppi.txt', 'r')
  except IOError:
    print 'Error: could not find \'HPRD_human_ppi.txt\'\
      dataset for creating PPI graph\n'
    return None

  ppiGraph = {}
  for line in f:
    l = line.split('\t')
    first = l[0]
    second = l[3]
    if ppiGraph.__contains__(first):
      ppiGraph[first].add(second)
    else:
      ppiGraph[first] = set()
      ppiGraph[first].add(second)
    if ppiGraph.__contains__(second):
      ppiGraph[second].add(first)
    else:
      ppiGraph[second] = set()
      ppiGraph[second].add(first)

  return ppiGraph
 

def intersect_ppi_graph(geneSet, ppiGraph):
  '''
  geneSet: set obj of GeneIDs as strs
  ppiGraph: a dict of GeneIDs as strs mapping to a set of GeneIDs
  Returns a subset dict containing only the adjlists for nodes in geneSet
  '''
  #if ppiGraph.keys() == []: 
  #  print 'Error: ppiGraph is empty'
  #  return None
  #elif type(geneSet) != set:
  #  print 'Error: first arg must be str set\n'
  #  return None
  #elif not __verify_adjlist_type__(ppiGraph):
  #  print 'Error: second arg must be dict of (str -> str set)\n'
  #  return None

  # capture interactions for g \in geneSet if g \in ppiGraph
  subset = {}
  for gene in geneSet:
    if gene in ppiGraph:
      intersect = geneSet.intersection(ppiGraph[gene])
      if len(intersect) != 0:
        subset[gene] = intersect
    #else:
    #  subset[gene] = set()

  # remove control
  if '--Control' in subset:
    subset.pop('--Control')

  return subset

def write_gene_names():
  '''
  Writes out gene names to ./txt_data/ for each dataset located in ./mat_data/
  '''
  data = os.walk('./mat_data')
  data = data.next() #data is a generator object

  if 'comm_data' not in data[1]:
    print 'Making output dir \'./txt_data\'\n'
    os.mkdir('./comm_data')

  from scipy.io import loadmat
  data = data[2] #only look at the files not dirs
  for fname in data:
    genes = loadmat('./mat_data/'+fname)
    print 'Writing ./txt_data/'+fname[:-4]+'.txt\n'
    f = open('./txt_data/'+fname[:-4]+'.txt', 'w')
    if 'names_new' in genes:
      genes = genes['names_new']
    elif 'names' in genes:
      genes = genes['names']
    else: # could not find gene names in the dataset
      continue
    for name in genes:
      f.write(str(name[0][0])+'\n')  
    f.close()

def __sort_comm_helper__(commone, commtwo):
  '''
  commone and commtwo: list of gene names (each a link community)
  returns 1 if len(commone) >= len(commtwo), -1 otherwise
  '''
  if len(commone) >= len(commtwo):
    return 1
  else:
    return -1

def sort_all_comm_data():
  '''
  Reads all the *comm2nodes.txt files in ./comm_data/ and sorts
  the communities according to descending size
  '''
  data = os.walk('./comm_data/')
  data = data.next() #data is a generator object

  if 'sorted' not in data[1]:
    print 'Making output dir \'./sorted\'\n'
    os.mkdir('./comm_data/sorted')

  data = data[2] #only look at the files not dirs
  for fname in data:
    if not fname.endswith('comm2nodes.txt'):
      continue
    else:
      f = open('./comm_data/'+fname, 'r')
      l = []
      for line in f:
        line = line.strip().split('\t')[1:] #lose the community number
        size = [str(len(line))] # prepend length to add to comm list
        l.append(size + line)
      l.sort(cmp = __sort_comm_helper__)
      l.reverse()
      f.close()
      f = open('./comm_data/sorted/'+fname, 'w')
      for line in l:
        f.write(('\t'.join(line)) + '\n')
      f.close()     

def sort_comm_data(fname):
  f = open(fname, 'r')
  l = []
  for line in f:
    line = line.strip().split('\t')[1:] #lose the community number
    size = [str(len(line))] # prepend length to add to comm list
    l.append(size + line)
  l.sort(cmp = __sort_comm_helper__)
  l.reverse()
  f.close()
  f = open('sorted_'+fname, 'w')
  for line in l:
    f.write(('\t'.join(line)) + '\n')
  f.close()     

def convert_adj_to_edgelist(ppiGraph):
  '''
  ppiGraph: an adjacency list of PPI's
    as a dict of GeneID strs mapping to sets of GeneID strs
  Returns an edgelist of the same graph as a set of GeneID
    2-tuples in which the first str is alphanumerically greater
  '''
  #if not __verify_adjlist_type__(ppiGraph):
  #  print 'Error: arg must be dict of (str -> str set)\n'
  #  return None

  edgelist = set()
  for key in ppiGraph:
    for val in ppiGraph[key]:
      if key > val:
        edgelist.add((key, val))
      else:
        edgelist.add((val, key))
  
  return edgelist

def convert_edge_to_adjlist(ppiGraph):
  '''
  ppiGraph: an edgelist of PPI's as a set of 2-sets of strs
  Returns an adjlist of the same graph as a dict of (str -> str set)
  '''
  #if len(ppiGraph) == 0:
  #  print 'Error: empty edgelist\n'
  #  return None
  #if not __verify_edgelist_type__(ppiGraph):
  #  print 'Error: cannot convert ppiGraph edgelist to adjlist because\
  #    edgelist input is not a set of str sets\n'
  #  return None
  
  adjlist = {}
  for pair in ppiGraph:
    if p[0] in adjlist:
      adjlist[p[0]].add(p[1])
    else:
      adjlist[p[0]]  = set()
      adjlist[p[0]].add(p[1])

    if p[1] in adjlist:
      adjlist[p[1]].add(p[0])
    else:
      adjlist[p[1]] = set()
      adjlist[p[1]].add(p[0])

  return adjlist

def __verify_edgelist_type__(ppiGraph):
  '''
  Returns true if ppiGraph is a set of 2-str sets (an edgelist)
  '''
  if type(ppiGraph) != set:
    return false
  else:
     for pair in ppiGraph:
       if type(pair) != tuple or len(pair) != 2:
         return false
  return true

def __verify_adjlist_type__(ppiGraph):
  '''
  Returns true if ppiGraph is a dictionary of strs -> str sets (an adjlist)
  '''
  if type(ppiGraph) != dict:
    return false
  elif len(ppiGraph) == 0:
    return true
  else:
    return (type(ppiGraph[ppiGraph.keys()[0]]) == set \
      and type(list(ppiGraph[ppiGraph.keys()[0]])[0]) == str)


def uniprotID_to_geneName():
  '''
  creates and returns a dict from uniprotIDs to gene name/symbol(s) (as a list)
  reads from './UNIPROT_SPROT_human_ppi.txt' to create map
    or looks for cPickle dump file 'uniprotID_to_geneName'
  '''
  if 'uniprotID_to_geneName' in os.listdir('.'):
    return cPickle.load(open('uniprotID_to_geneName', 'r'))
  elif 'UNIPROT_SPROT_human_ppi.txt' not in os.listdir('.'):
    print 'Could not find file for reading uniprotID to geneName\n'
    return None
   
  f = open('UNIPROT_SPROT_human_ppi.txt', 'r')
  id2gn = {}
  numlines = 4413058
  count = 0
  lastcount = 0
  while(True): #do not mix 'for line in f' with f.readline() calls
    line = f.readline()
    count += 1
    if(line == ''):
      break
    #find next accession id entry
    if line.startswith('AC '):
      ids = __get_uniprotID_list_from_string__(line)
      line = f.readline()
      count += 1
      #synonymous AC ids may be on sequential lines
      while(line.startswith('AC ')):
        ids.extend(__get_uniprotID_list_from_string__(line))
        line = f.readline()
        count += 1
      #find all corresponding gene symbol entries
      while((line.startswith('AC ') or line.startswith('GN ')) == False):
        line = f.readline()
        count += 1
        if(line == ''): 
          break
      if(line.startswith('AC ')): # no gene symbols found for ids
        continue # next iteration of outer while
      else: #line.startswith('GN ')
        symbols = __get_geneName_list_from_string__(line)
        line = f.readline()
        count += 1
        #synonymous gene names may be on sequential lines
        while(line.startswith('GN ')):
          if(line != 'GN   and\n'):
            symbols.extend(__get_geneName_list_from_string__(line))
          line = f.readline()
          count += 1
        #have now read the synonymous ids and corresponding gene symbols for this entry
        # put into dict
        for ident in ids:
          for symb in symbols:
            if(ident in id2gn.keys()):
              id2gn[ident] = set()
              id2gn[ident].add(symb)
            else:
              id2gn[ident].add(symb)
        #if(len(ids) != 0 and len(symbols) != 0):
          #print_tupl = (ids[0],symbols[0], len(ids), len(symbols))
          #print 'Read %s:%s, cardinality of %d:%d\n' % print_tupl 
        if(count - lastcount > 5000):
          print 'Progress: %.3f%%' % (float(count)/numlines * 100)
          lastcount = count
  # write the dict to file
  print 'DONE!'
  cPickle.dump(id2gn, open('uniprotID_to_geneName', 'w'))
  return id2gn

def __get_geneName_list_from_string__(string):
  symbols = string.strip().split()[1:]
  symbols = [s.split('=') for s in symbols]
  geneNames = []
  syn = False
  #ugly code
  for token in symbols:
    if(syn):
      if(len(token) == 2):
        return geneNames
      else:
        geneNames.append(token[0][:-1])
    if(len(token) == 2):
      if(token[0] == 'Name'):
        geneNames.append(token[1][:-1])
      elif(token[0] == 'Synonyms'):
        geneNames.append(token[1][:-1])
        syn = True
      else:
        break
  return geneNames

def __get_uniprotID_list_from_string__(string):
  ids = string.strip().split()[1:]
  ids = [s[:-1] for s in ids] #remove trailing ';'
  return ids

if __name__ == '__main__':
  data = os.walk('./')
  data = data.next() #data is a generator object

  if 'mat_data' not in data[1]:
    print 'Could not find mat_data dir in current directory\n'
  elif 'HPRD_human_ppi.txt' not in data[2]:
    print 'Could not find \'HPRD_human_ppi.txt\' in current directory\n'
  elif 'lc.py' not in data[2]:
    print 'Could not find \'lc.py\' in current directory\n'

  # see readme.txt ======================

  # STEP 3 ------------------------------
  write_gene_names()
  # STEP 4 ------------------------------
  write_all_edgelists()

  # STEP 5 ------------------------------
  args = os.listdir('./edge_data')
  delimiter = '\t'
  dirs = os.walk('./')
  dirs = dirs.next()[1]
  if 'comm_data' not in dirs:
    print 'Making output dir\'./comm_data\'\n'
    os.mkdir('./comm_data')
  i=0
  while i != len(args):
    print "# loading input..." + args[i]
    basename = os.path.splitext(args[i])[0]
    basename = basename.split('/')
    basename = basename[len(basename)-1] #lose the path to the file
    # load network from edgelist
    adj,edges = read_edgelist(args[i], delimiter=delimiter) 

    if threshold:
      edge2cid,D_thr = HLC( adj,edges ).single_linkage( threshold )
      print "# D_thr = %f" % D_thr
      write_edge2cid( edge2cid,"%s_thrS%f_thrD%f" % (basename,threshold,D_thr), delimiter=delimiter, path='./comm_data/' )
    else:
      edge2cid,S_max,D_max,list_D = HLC( adj,edges ).single_linkage()
      f = open('./comm_data/'+"%s_thr_D.txt" % basename,'w')
      for s,D in list_D:
        print >>f, s, D
      f.close()
      print "# D_max = %f\n# S_max = %f" % (D_max,S_max)
      write_edge2cid( edge2cid,"%s_maxS%f_maxD%f" % (basename,S_max,D_max), delimiter=delimiter, path='./comm_data/' )
    print 'finished writing %s\n' % args[i]
    i += 1

  # STEP 6 ------------------------------
  sort_all_comm_data()
