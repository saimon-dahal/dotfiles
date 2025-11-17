#!/usr/bin/env bash
# Yazi compression script
# Place this in ~/.config/yazi/scripts/compress.sh
# Make it executable: chmod +x ~/.config/yazi/scripts/compress.sh

# Check if files were provided
if [ $# -eq 0 ]; then
    echo "No files selected for compression"
    read -n 1 -s -r -p "Press any key to continue..."
    exit 1
fi

# Get the directory of the first file
FIRST_FILE="$1"
DIR=$(dirname "$FIRST_FILE")

# Generate default archive name based on current directory
DEFAULT_NAME="archive-$(date +%Y%m%d-%H%M%S).zip"

# Prompt for archive name
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 COMPRESS FILES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Files to compress ($# items):"
for file in "$@"; do
    echo "  • $(basename "$file")"
done
echo ""
echo -n "Archive name [$DEFAULT_NAME]: "
read ARCHIVE_NAME

# Use default if empty
if [ -z "$ARCHIVE_NAME" ]; then
    ARCHIVE_NAME="$DEFAULT_NAME"
fi

# Ensure .zip extension
if [[ ! "$ARCHIVE_NAME" =~ \.zip$ ]]; then
    ARCHIVE_NAME="${ARCHIVE_NAME}.zip"
fi

# Use full path for archive in the source directory
ARCHIVE_PATH="$DIR/$ARCHIVE_NAME"

# Check if archive already exists
if [ -f "$ARCHIVE_PATH" ]; then
    echo ""
    echo -n "⚠️  Archive '$ARCHIVE_NAME' exists. Overwrite? (y/N): "
    read OVERWRITE
    if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
        echo ""
        echo "❌ Compression cancelled"
        read -n 1 -s -r -p "Press any key to continue..."
        exit 0
    fi
    rm -f "$ARCHIVE_PATH"
fi

# Create archive (cd to dir first to avoid full paths in zip)
echo ""
echo "Compressing..."
cd "$DIR"

# Build list of basenames for zip
ITEMS=()
for file in "$@"; do
    ITEMS+=("$(basename "$file")")
done

# Create the zip
zip -r "$ARCHIVE_NAME" "${ITEMS[@]}" 2>&1

if [ $? -eq 0 ]; then
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "✅ Successfully created: $ARCHIVE_NAME"
    SIZE=$(du -h "$ARCHIVE_NAME" | cut -f1)
    echo "📦 Size: $SIZE"
    echo "📁 Location: $DIR"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
else
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "❌ Compression failed"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi

echo ""
read -n 1 -s -r -p "Press any key to continue..."
