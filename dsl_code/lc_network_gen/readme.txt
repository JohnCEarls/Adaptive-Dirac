LC output from the PPI network of a given dataset located in './comm_data/'
./comm_data/sorted contains *comm2nodes for each dataset sorted on size of each generated subnetwork

-------------------------------------------------------

How to generate the community data:

0) CD such that ppi.py and lc.py are in the current directory
1) place datasets (as mat files) into ./mat_data
2) place HPRD PPI data (HPRD_human_ppi.txt) into ./
3) reformat mat data into list of genes per set to ./txt_data 
   using ppi.write_gene_name() (a list of gene names for each dataset)
4) create PPI interaction graphs for each data set in ./txt_data and 
   write to ./edge_data using ppi.write_all_edgelists()
   ppi.write_all_edgelists:
     make ppi interaction graph from HPRD data
     for each data set in ./txt_data
       - read set of gene names
       - make interaction graph only with genes in this dataset
       - convert adjlist to edgelist
       - write edgelist to ./edge_data
5) write communities to ./comm_data using 'python lc.py ./edge_data/*'
6) sort each dataset's community list by size to 
   ./comm_data/sorted using ppi.sort_comm_data()

------------------ from the command line (linux) --------------------

0) CD such that ppi.py and lc.py are in the current directory
1) place datasets (as mat files) into ./mat_data
2) place HPRD PPI data (HPRD_human_ppi.txt) into ./
3) python
   >>> from ppi import write_gene_names
   >>> write_gene_names()
4) python
   >>> from ppi import write_all_edgelists
   >>> write_all_edgelists()
5) python lc.py ./edge_data/*
6) python
   >>> from ppi import sort_comm_data
   >>> sort_comm_data()

Steps 3-6 done in one command by 'python ppi.py'
