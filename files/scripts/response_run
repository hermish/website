#!/bin/bash

# Set directory
cd -- "$(dirname "$BASH_SOURCE")"

# Download required scripts
curl -o response_overhead.py https://www.ocf.berkeley.edu/~hermish/files/scripts/response_overhead.txt
curl -o response_analysis.R https://www.ocf.berkeley.edu/~hermish/files/scripts/response_analysis.R

# Run analysis
python response_overhead.py

# Clean up workspace
rm response_overhead.py
rm response_analysis.R