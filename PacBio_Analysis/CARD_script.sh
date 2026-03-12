# Loop through each .fasta file in the ./assemblies directory
for fasta_file in ./assemblies/*.fasta; do
    # Extract the filename without extension
    filename=$(basename "$fasta_file" .fasta)
    
    # Define output path in the card folder with a unique name
    output_file="./CARD_AMR/${filename}_rgi_output.txt"
    
    # Run the RGI tool using Docker
    docker run -v "$PWD:/data" quay.io/biocontainers/rgi:6.0.3--pyha8f3691_0 \
        rgi main -i "/data/$fasta_file" -o "/data/$output_file"
done
