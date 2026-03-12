OUTPUT_BASE_DIR="/mnt/out"
# Create the output base directory if it doesn't exist
mkdir -p "$OUTPUT_BASE_DIR"

# Loop through all .fasta files in the current directory
for fasta_file in *.fasta; do
    if [[ -e "$fasta_file" ]]; then
        output_dir="$OUTPUT_BASE_DIR/$(basename "$fasta_file" .fasta)"
        mkdir -p "$output_dir"  # Create the output directory

        # Debugging output to see if the directory was created
        if [[ $? -eq 0 ]]; then
            echo "Created directory: $output_dir"
        else
            echo "Failed to create directory: $output_dir"
        fi

        # Log the fasta file being processed
        echo "Processing file: $fasta_file"

        # Construct and log the Docker command
        docker_command="docker run --rm -v \"$(pwd)\":/mnt/ kbessonov/mob_suite:3.0.3 mob_recon --infile \"/mnt/$fasta_file\" --force -o \"$output_dir\""
        echo "Running command: $docker_command"

        # Run the Docker command
        eval $docker_command || { echo "Docker command failed for $fasta_file"; exit 1; }
    else
        echo "No .fasta files found in the assemblies directory."
    fi
done

