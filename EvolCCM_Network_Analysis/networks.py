import argparse
import requests
import pandas as pd

# Define the base URL for the Cytoscape REST API
base_url = 'http://localhost:1234/v1/'

# Create an argument parser to accept the data file as an argument
parser = argparse.ArgumentParser(description='Create a network in Cytoscape from a CSV file.')
parser.add_argument('data_file', help='Path to the CSV file containing "Source" and "Target" columns.')

# Parse the command-line arguments
args = parser.parse_args()

# Load your data from the CSV file
data = pd.read_csv(args.data_file)

# Create a new empty network
response = requests.post(base_url + 'networks')
network_id = response.json()['networkSUID']

# Create a dictionary to store node IDs and their corresponding SUIDs
node_suids = {}

# Add nodes to the network
for _, row in data.iterrows():
    source = row['Source']
    target = row['Target']
    
    if source not in node_suids:
        node_suids[source] = requests.post(base_url + f'networks/{network_id}/nodes', json={"data": {"id": source}}).json()['networkSUID']
    
    if target not in node_suids:
        node_suids[target] = requests.post(base_url + f'networks/{network_id}/nodes', json={"data": {"id": target}}).json()['networkSUID']

# Add edges to the network
for _, row in data.iterrows():
    source = row['Source']
    target = row['Target']
    
    edge_data = {
        "data": {
            "source": node_suids[source],
            "target": node_suids[target]
        }
    }
    
    requests.post(base_url + f'networks/{network_id}/edges', json=edge_data)

print(f"Network created with ID: {network_id}")

