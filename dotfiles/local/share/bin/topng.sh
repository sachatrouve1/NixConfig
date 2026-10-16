#!/usr/bin/env bash

remove_source=false
files=()

# Parse arguments
for arg in "$@"; do
    case "$arg" in
        -rm|--rm)
            remove_source=true
            ;;
        *)
            files+=("$arg")
            ;;
    esac
done

# Check if input file is provided
if [ ${#files[@]} -eq 0 ]; then
    echo "Usage: topng [-rm] <imagefile...>"
    exit 1
fi

exit_code=0

for input in "${files[@]}"; do
    # Check if input file exists
    if [ ! -f "$input" ]; then
        echo "Error: '$input' not found." >&2
        exit_code=1
        continue
    fi

    # Remove extension to get base name
    base="${input%.*}"
    output="${base}.png"

    # Convert using ImageMagick
    if magick "$input" "$output"; then
        echo "Converted: $output"
        if [ "$remove_source" = true ]; then
            input_real=$(realpath "$input" 2>/dev/null || echo "$input")
            output_real=$(realpath "$output" 2>/dev/null || echo "$output")
            if [ "$input_real" != "$output_real" ]; then
                rm -f "$input"
                echo "Removed original: $input"
            fi
        fi
    else
        echo "Error: Failed to convert '$input'." >&2
        exit_code=1
    fi
done

exit "$exit_code"
