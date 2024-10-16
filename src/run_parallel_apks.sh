#!/bin/bash

# Check if correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_csv> <output_dir> <number_of_jobs>"
    exit 1
fi

# Get parameters
input_csv="$1"
output_dir="$2"
number_of_jobs="$3"

# Generate commands for GNU parallel
commands_file="commands_with_checks.txt"
> "$commands_file"  # Clear the file if it already exists

# Read CSV file and process each line
while IFS=, read -r folder_path package_name; do
    # Find the .apk file within the folder
    apk_file=$(find "$folder_path" -type f -name "*.apk" | head -n 1)

    # Check if an APK file was found
    if [ -z "$apk_file" ]; then
        echo "No APK file found in $folder_path, skipping."
        continue
    fi

    # Define output file path
    output_file="${output_dir}/${package_name}.apk"

    # Generate command with existence check
    echo "[ -f \"$output_file\" ] || python2 gen_disguise.py -i \"$apk_file\" individual -o \"$output_file\"" >> "$commands_file"
done < <(tail -n +2 "$input_csv")  # Skips the header row if present

# Run commands with GNU parallel
cat "$commands_file" | parallel -j "$number_of_jobs"
