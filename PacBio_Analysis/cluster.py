from Bio import AlignIO
from Bio.Phylo.TreeConstruction import DistanceCalculator
from scipy.spatial.distance import squareform
from scipy.cluster.hierarchy import linkage, dendrogram
import numpy as np
import matplotlib.pyplot as plt

# Load the alignment file
alignment_file = r"C:\Users\syl218\Desktop\Aaron_white_ecoli\panarooOutHPC\panarooOut\panarooOut\core_gene_alignment.aln"
alignment = AlignIO.read(alignment_file, "fasta")  # Use "fasta" for MAFFT alignment

# Initialize the calculator with p-distance
calculator = DistanceCalculator('identity')  # 'identity' calculates the proportion of identical sites


distance_matrix = calculator.get_distance(alignment)


print("Distance matrix structure:")
print(distance_matrix)


distance_matrix_values = distance_matrix.matrix


print("Distance matrix values:")
print(distance_matrix_values)

# Check if it's a list of lists or a dictionary and convert
if isinstance(distance_matrix_values, dict):

    seq_names = list(distance_matrix_values.keys())
    matrix = np.array([[distance_matrix_values[seq1][seq2] for seq2 in seq_names] for seq1 in seq_names])
elif isinstance(distance_matrix_values, list):

    matrix = np.array(distance_matrix_values)
else:
    raise TypeError("Unexpected format for the distance matrix")


print("Distance matrix as 2D array:")
print(matrix)

# UPGMA
condensed_distances = squareform(matrix)  

# Perform hierarchical clustering
linkage_matrix = linkage(condensed_distances, method='average')

# Plot dendrogram
plt.figure(figsize=(15, 8))
dendrogram(
    linkage_matrix,
    labels=distance_matrix.names,
    leaf_rotation=90,
    leaf_font_size=10
)
plt.title("Hierarchical Clustering Dendrogram (UPGMA)")
plt.xlabel("Sequences")
plt.ylabel("Distance")
plt.show()