#!/bin/bash
# Script to add your photo to the website
# Usage: ./add_photo.sh /path/to/your/photo.jpg

if [ -z "$1" ]; then
    echo "Usage: ./add_photo.sh /path/to/your/photo.jpg"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: File not found: $1"
    exit 1
fi

cp "$1" public/images/renat-photo.jpg
echo "Photo added successfully!"
echo "Run 'ruby build.rb' to rebuild the preview."
