import os
import pandas as pd

clust_dict = {}
root_dir = '../mob_recon_clusters'
for path, dirname, filenames in os.walk(root_dir):
    for file in filenames:
        cluster = path.split('\\')[-2]
        cluster_file = path.split('\\')[-1]
        print(cluster, cluster_file)
        if 'contig_report.txt' in file:
            df = pd.read_csv(os.path.join(path, file), sep='\t')
            print(df['molecule_type'])
