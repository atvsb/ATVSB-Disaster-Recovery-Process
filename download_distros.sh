#!/bin/bash

# ============================================================================
# Linux Distribution Automated Download and Verification Script
# ============================================================================
# This script automates the download and verification of various Linux
# distributions for disaster recovery and live CD/install purposes.
#
# Usage: ./download_distros.sh [options]
#   -d, --distro <name>    Download specific distribution
#   -a, --all              Download all distributions
#   -l, --list             List available distributions
#   -o, --output <dir>     Output directory (default: ./downloads)
#   -h, --help             Show this help message
# ============================================================================

set -e

# Configuration
OUTPUT_DIR="./downloads"
VERIFY_CHECKSUMS=true
VERBOSE=false

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored messages
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check required dependencies
check_dependencies() {
    local missing_deps=()
    
    if ! command_exists wget && ! command_exists curl; then
        missing_deps+=("wget or curl")
    fi
    
    if ! command_exists sha256sum && ! command_exists shasum; then
        missing_deps+=("sha256sum or shasum")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing required dependencies:"
        for dep in "${missing_deps[@]}"; do
            echo "  - $dep"
        done
        exit 1
    fi
}

# Function to download a file
download_file() {
    local url="$1"
    local output="$2"
    
    print_info "Downloading: $url"
    
    if command_exists wget; then
        wget -c --progress=bar:force "$url" -O "$output" 2>&1
    elif command_exists curl; then
        curl -L -C - --progress-bar "$url" -o "$output"
    else
        print_error "No download tool available (wget or curl required)"
        return 1
    fi
}

# Function to verify checksum
verify_checksum() {
    local file="$1"
    local expected_checksum="$2"
    local checksum_type="${3:-sha256}"
    
    if [ ! -f "$file" ]; then
        print_error "File not found: $file"
        return 1
    fi
    
    print_info "Verifying checksum for $(basename "$file")..."
    
    local actual_checksum
    if command_exists sha256sum; then
        actual_checksum=$(sha256sum "$file" | awk '{print $1}')
    elif command_exists shasum; then
        actual_checksum=$(shasum -a 256 "$file" | awk '{print $1}')
    else
        print_warning "No checksum tool available, skipping verification"
        return 0
    fi
    
    if [ "$actual_checksum" = "$expected_checksum" ]; then
        print_success "Checksum verification passed"
        return 0
    else
        print_error "Checksum verification failed!"
        print_error "Expected: $expected_checksum"
        print_error "Got:      $actual_checksum"
        return 1
    fi
}

# Function to download Ubuntu
download_ubuntu() {
    local version="${1:-22.04.3}"
    local arch="${2:-amd64}"
    local output_file="$OUTPUT_DIR/ubuntu-${version}-desktop-${arch}.iso"
    
    print_info "Downloading Ubuntu $version ($arch)..."
    
    # Ubuntu download URL
    local url="https://releases.ubuntu.com/${version%.*}/ubuntu-${version}-desktop-${arch}.iso"
    local checksum_url="https://releases.ubuntu.com/${version%.*}/SHA256SUMS"
    
    mkdir -p "$OUTPUT_DIR"
    
    # Download ISO
    if [ ! -f "$output_file" ]; then
        download_file "$url" "$output_file"
    else
        print_warning "File already exists: $output_file"
    fi
    
    # Download and verify checksum
    if [ "$VERIFY_CHECKSUMS" = true ]; then
        local checksum_file="$OUTPUT_DIR/ubuntu-${version}-SHA256SUMS"
        download_file "$checksum_url" "$checksum_file"
        
        local expected_checksum=$(grep "ubuntu-${version}-desktop-${arch}.iso" "$checksum_file" | awk '{print $1}')
        if [ -n "$expected_checksum" ]; then
            verify_checksum "$output_file" "$expected_checksum"
        else
            print_warning "Could not find checksum in SHA256SUMS file"
        fi
    fi
    
    print_success "Ubuntu download completed: $output_file"
}

# Function to download Debian
download_debian() {
    local version="${1:-12.4.0}"
    local arch="${2:-amd64}"
    local output_file="$OUTPUT_DIR/debian-${version}-${arch}-netinst.iso"
    
    print_info "Downloading Debian $version ($arch)..."
    
    # Debian download URL (using cdimage.debian.org)
    local url="https://cdimage.debian.org/debian-cd/current/${arch}/iso-cd/debian-${version}-${arch}-netinst.iso"
    local checksum_url="https://cdimage.debian.org/debian-cd/current/${arch}/iso-cd/SHA256SUMS"
    
    mkdir -p "$OUTPUT_DIR"
    
    # Download ISO
    if [ ! -f "$output_file" ]; then
        download_file "$url" "$output_file"
    else
        print_warning "File already exists: $output_file"
    fi
    
    # Download and verify checksum
    if [ "$VERIFY_CHECKSUMS" = true ]; then
        local checksum_file="$OUTPUT_DIR/debian-${version}-SHA256SUMS"
        download_file "$checksum_url" "$checksum_file"
        
        local expected_checksum=$(grep "debian-${version}-${arch}-netinst.iso" "$checksum_file" | awk '{print $1}')
        if [ -n "$expected_checksum" ]; then
            verify_checksum "$output_file" "$expected_checksum"
        else
            print_warning "Could not find checksum in SHA256SUMS file"
        fi
    fi
    
    print_success "Debian download completed: $output_file"
}

# Function to download Fedora
download_fedora() {
    local version="${1:-39}"
    local arch="${2:-x86_64}"
    local output_file="$OUTPUT_DIR/Fedora-Workstation-Live-${arch}-${version}.iso"
    
    print_info "Downloading Fedora $version ($arch)..."
    
    # Fedora download URL
    local url="https://download.fedoraproject.org/pub/fedora/linux/releases/${version}/Workstation/${arch}/iso/Fedora-Workstation-Live-${arch}-${version}-1.5.iso"
    local checksum_url="https://download.fedoraproject.org/pub/fedora/linux/releases/${version}/Workstation/${arch}/iso/Fedora-Workstation-${version}-1.5-${arch}-CHECKSUM"
    
    mkdir -p "$OUTPUT_DIR"
    
    # Download ISO
    if [ ! -f "$output_file" ]; then
        download_file "$url" "${output_file}"
    else
        print_warning "File already exists: $output_file"
    fi
    
    # Note: Fedora checksums require more complex parsing
    if [ "$VERIFY_CHECKSUMS" = true ]; then
        print_warning "Manual checksum verification recommended for Fedora"
        print_info "Download checksum file from: $checksum_url"
    fi
    
    print_success "Fedora download completed: $output_file"
}

# Function to download Rocky Linux
download_rocky() {
    local version="${1:-9.3}"
    local arch="${2:-x86_64}"
    local output_file="$OUTPUT_DIR/Rocky-${version}-${arch}-minimal.iso"
    
    print_info "Downloading Rocky Linux $version ($arch)..."
    
    # Rocky Linux download URL
    local url="https://download.rockylinux.org/pub/rocky/${version%.*}/isos/${arch}/Rocky-${version}-${arch}-minimal.iso"
    local checksum_url="https://download.rockylinux.org/pub/rocky/${version%.*}/isos/${arch}/CHECKSUM"
    
    mkdir -p "$OUTPUT_DIR"
    
    # Download ISO
    if [ ! -f "$output_file" ]; then
        download_file "$url" "$output_file"
    else
        print_warning "File already exists: $output_file"
    fi
    
    # Download and verify checksum
    if [ "$VERIFY_CHECKSUMS" = true ]; then
        local checksum_file="$OUTPUT_DIR/rocky-${version}-CHECKSUM"
        download_file "$checksum_url" "$checksum_file"
        
        local expected_checksum=$(grep "Rocky-${version}-${arch}-minimal.iso" "$checksum_file" | grep "SHA256" | awk '{print $4}')
        if [ -n "$expected_checksum" ]; then
            verify_checksum "$output_file" "$expected_checksum"
        else
            print_warning "Could not find checksum in CHECKSUM file"
        fi
    fi
    
    print_success "Rocky Linux download completed: $output_file"
}

# Function to download Arch Linux
download_arch() {
    local arch="${1:-x86_64}"
    local output_file="$OUTPUT_DIR/archlinux-latest-${arch}.iso"
    
    print_info "Downloading Arch Linux (latest) ($arch)..."
    
    # Arch Linux download URL (using a mirror)
    local url="https://mirror.rackspace.com/archlinux/iso/latest/archlinux-x86_64.iso"
    local checksum_url="https://mirror.rackspace.com/archlinux/iso/latest/sha256sums.txt"
    
    mkdir -p "$OUTPUT_DIR"
    
    # Download ISO
    if [ ! -f "$output_file" ]; then
        download_file "$url" "$output_file"
    else
        print_warning "File already exists: $output_file"
    fi
    
    # Download and verify checksum
    if [ "$VERIFY_CHECKSUMS" = true ]; then
        local checksum_file="$OUTPUT_DIR/arch-sha256sums.txt"
        download_file "$checksum_url" "$checksum_file"
        
        local expected_checksum=$(grep "archlinux-x86_64.iso" "$checksum_file" | awk '{print $1}')
        if [ -n "$expected_checksum" ]; then
            verify_checksum "$output_file" "$expected_checksum"
        else
            print_warning "Could not find checksum in sha256sums.txt file"
        fi
    fi
    
    print_success "Arch Linux download completed: $output_file"
}

# Function to download Linux Mint
download_mint() {
    local version="${1:-21.3}"
    local edition="${2:-cinnamon}"
    local arch="${3:-64bit}"
    local output_file="$OUTPUT_DIR/linuxmint-${version}-${edition}-${arch}.iso"
    
    print_info "Downloading Linux Mint $version ($edition, $arch)..."
    
    # Linux Mint download URL
    local url="https://mirrors.edge.kernel.org/linuxmint/stable/${version}/linuxmint-${version}-${edition}-${arch}.iso"
    local checksum_url="https://mirrors.edge.kernel.org/linuxmint/stable/${version}/sha256sum.txt"
    
    mkdir -p "$OUTPUT_DIR"
    
    # Download ISO
    if [ ! -f "$output_file" ]; then
        download_file "$url" "$output_file"
    else
        print_warning "File already exists: $output_file"
    fi
    
    # Download and verify checksum
    if [ "$VERIFY_CHECKSUMS" = true ]; then
        local checksum_file="$OUTPUT_DIR/mint-${version}-sha256sum.txt"
        download_file "$checksum_url" "$checksum_file"
        
        local expected_checksum=$(grep "linuxmint-${version}-${edition}-${arch}.iso" "$checksum_file" | awk '{print $1}')
        if [ -n "$expected_checksum" ]; then
            verify_checksum "$output_file" "$expected_checksum"
        else
            print_warning "Could not find checksum in sha256sum.txt file"
        fi
    fi
    
    print_success "Linux Mint download completed: $output_file"
}

# Function to list available distributions
list_distributions() {
    echo ""
    echo "Available Linux Distributions:"
    echo "==============================="
    echo "1. ubuntu     - Ubuntu Desktop LTS"
    echo "2. debian     - Debian Stable (netinst)"
    echo "3. fedora     - Fedora Workstation"
    echo "4. rocky      - Rocky Linux (minimal)"
    echo "5. arch       - Arch Linux (latest)"
    echo "6. mint       - Linux Mint (Cinnamon)"
    echo ""
}

# Function to show usage
show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -d, --distro <name>    Download specific distribution"
    echo "                         (ubuntu, debian, fedora, rocky, arch, mint)"
    echo "  -a, --all              Download all distributions"
    echo "  -l, --list             List available distributions"
    echo "  -o, --output <dir>     Output directory (default: ./downloads)"
    echo "  --no-verify            Skip checksum verification"
    echo "  -h, --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -d ubuntu           Download Ubuntu"
    echo "  $0 -d debian -o /mnt   Download Debian to /mnt"
    echo "  $0 -a                  Download all distributions"
    echo ""
}

# Parse command line arguments
DISTRO=""
DOWNLOAD_ALL=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--distro)
            DISTRO="$2"
            shift 2
            ;;
        -a|--all)
            DOWNLOAD_ALL=true
            shift
            ;;
        -l|--list)
            list_distributions
            exit 0
            ;;
        -o|--output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        --no-verify)
            VERIFY_CHECKSUMS=false
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Main execution
main() {
    print_info "Linux Distribution Download Script"
    print_info "==================================="
    echo ""
    
    # Check dependencies
    check_dependencies
    
    # Create output directory
    mkdir -p "$OUTPUT_DIR"
    print_info "Output directory: $OUTPUT_DIR"
    echo ""
    
    # Download distributions
    if [ "$DOWNLOAD_ALL" = true ]; then
        print_info "Downloading all distributions..."
        download_ubuntu
        download_debian
        download_fedora
        download_rocky
        download_arch
        download_mint
    elif [ -n "$DISTRO" ]; then
        case "$DISTRO" in
            ubuntu)
                download_ubuntu
                ;;
            debian)
                download_debian
                ;;
            fedora)
                download_fedora
                ;;
            rocky)
                download_rocky
                ;;
            arch)
                download_arch
                ;;
            mint)
                download_mint
                ;;
            *)
                print_error "Unknown distribution: $DISTRO"
                list_distributions
                exit 1
                ;;
        esac
    else
        print_error "No distribution specified"
        show_help
        exit 1
    fi
    
    echo ""
    print_success "All downloads completed successfully!"
}

# Run main function
main
