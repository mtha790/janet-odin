#!/bin/bash

# Build script for Janet-Odin bindings

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default values
BUILD_MODE="debug"
TARGET=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -release)
            BUILD_MODE="release"
            shift
            ;;
        -test)
            TARGET="test"
            shift
            ;;
        *)
            TARGET="$1"
            shift
            ;;
    esac
done

# Build flags
ODIN_FLAGS="-out:janet_odin"

if [[ "$BUILD_MODE" == "release" ]]; then
    ODIN_FLAGS="$ODIN_FLAGS -opt:3"
else
    ODIN_FLAGS="$ODIN_FLAGS -opt:0"
fi

# Add Janet library linking flags
# For macOS, assuming Janet is installed via Homebrew
if [[ "$OSTYPE" == "darwin"* ]]; then
    JANET_LIB_PATH="/opt/homebrew/lib"
    JANET_INCLUDE_PATH="/opt/homebrew/include/janet"
    # Check if Janet is installed
    if [[ ! -d "$JANET_INCLUDE_PATH" ]]; then
        JANET_LIB_PATH="/usr/local/lib"
        JANET_INCLUDE_PATH="/usr/local/include/janet"
    fi
else
    # Linux default paths
    JANET_LIB_PATH="/usr/local/lib"
    JANET_INCLUDE_PATH="/usr/local/include/janet"
fi

# Check if Janet is installed
if [[ ! -f "$JANET_LIB_PATH/libjanet.a" ]] && [[ ! -f "$JANET_LIB_PATH/libjanet.so" ]]; then
    echo -e "${RED}Error: Janet library not found at $JANET_LIB_PATH${NC}"
    echo "Please install Janet first: https://janet-lang.org/docs/index.html"
    exit 1
fi

ODIN_FLAGS="$ODIN_FLAGS -extra-linker-flags:-L$JANET_LIB_PATH -extra-linker-flags:-ljanet"

# Build or test
if [[ "$TARGET" == "test" ]]; then
    echo -e "${GREEN}Running tests...${NC}"
    odin test tests -file
else
    echo -e "${GREEN}Building Janet-Odin bindings...${NC}"
    echo "Janet library path: $JANET_LIB_PATH"
    echo "Janet include path: $JANET_INCLUDE_PATH"
    
    # Build the main package
    if [[ -f "src/bindings.odin" ]]; then
        odin build src -out:janet_odin $ODIN_FLAGS
    else
        echo -e "${RED}No source files found yet${NC}"
    fi
fi