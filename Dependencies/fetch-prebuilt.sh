
#!/usr/bin/env bash
set -euo pipefail

REPO="SideStore/em_proxy"
TAG="build"
BASE_URL="https://github.com/${REPO}/releases/download/${TAG}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

FILES=(
    "em_proxy.h"
    "em_proxy.swift"
    "libem_proxy-ios.a"
    "libem_proxy-sim.a"
)

echo "Downloading prebuilt em_proxy binaries..."

for FILE in "${FILES[@]}"; do
    echo "Downloading ${FILE}..."

    curl \
        --fail \
        --location \
        --silent \
        --show-error \
        --retry 3 \
        "${BASE_URL}/${FILE}" \
        --output "${FILE}.tmp"

    if [ ! -s "${FILE}.tmp" ]; then
        echo "ERROR: ${FILE} is empty or missing"
        rm -f "${FILE}.tmp"
        exit 1
    fi

    mv "${FILE}.tmp" "${FILE}"
done

echo "All em_proxy files downloaded successfully."
