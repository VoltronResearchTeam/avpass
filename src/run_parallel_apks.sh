#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_csv> <output_dir> <number_of_jobs>"
    exit 1
fi

# Get parameters
input_csv="$1"
output_dir="$2"
number_of_jobs="$3"

# Generate commands for GNU parallel for copying
copy_commands="copy_commands.txt"
> "$copy_commands"  # Clear the file if it already exists

# Generate commands for running gen_disguise.py
process_commands="commands_with_checks.txt"
> "$process_commands"

# Read CSV file and prepare copy and process commands
while IFS=, read -r folder_path package_name; do
    # Find the .apk file within the folder
    apk_file=$(find "$folder_path" -type f -name "*.apk" | head -n 1)

    # Check if an APK file was found
    if [ -z "$apk_file" ]; then
        echo "No APK file found in $folder_path, skipping."
        continue
    fi

    # Define the target file name for copying in the current directory
    copied_apk="${package_name}.apk"

    # Generate copy command to copy the APK to the current directory
    echo "[ -f \"$copied_apk\" ] || cp \"$apk_file\" \"$copied_apk\"" >> "$copy_commands"

    # Define output file path
    output_file="${output_dir}/${package_name}.apk"

    # Generate gen_disguise.py command with existence check
    echo "[ -f \"$output_file\" ] || python2 gen_disguise.py -i \"$copied_apk\" individual -o \"$output_file\"" >> "$process_commands"
done < <(tail -n +2 "$input_csv")  # Skips the header row if present

# Run copy commands in parallel
cat "$copy_commands" | parallel -j "$number_of_jobs"

# Run gen_disguise.py commands in parallel
cat "$process_commands" | parallel -j "$number_of_jobs"
