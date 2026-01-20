#!/bin/bash

# ============================================================================
# Test Script for Linux Distribution Download Script
# ============================================================================
# This script validates the download_distros.sh script's functionality
# without requiring actual downloads.
# ============================================================================

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASSED=0
FAILED=0

print_test() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

print_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((PASSED++))
}

print_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((FAILED++))
}

echo "Testing download_distros.sh script"
echo "==================================="
echo ""

# Test 1: Script exists and is executable
print_test "Checking if script exists and is executable"
if [ -f "./download_distros.sh" ] && [ -x "./download_distros.sh" ]; then
    print_pass "Script exists and is executable"
else
    print_fail "Script not found or not executable"
fi

# Test 2: Help option works
print_test "Testing help option"
if ./download_distros.sh --help > /dev/null 2>&1; then
    print_pass "Help option works"
else
    print_fail "Help option failed"
fi

# Test 3: List option works
print_test "Testing list option"
if ./download_distros.sh --list > /dev/null 2>&1; then
    print_pass "List option works"
else
    print_fail "List option failed"
fi

# Test 4: Script requires a distribution argument
print_test "Testing that script requires arguments"
if ! ./download_distros.sh > /dev/null 2>&1; then
    print_pass "Script correctly requires arguments"
else
    print_fail "Script should fail without arguments"
fi

# Test 5: Script rejects invalid distribution
print_test "Testing invalid distribution handling"
if ! ./download_distros.sh -d invalid_distro > /dev/null 2>&1; then
    print_pass "Script correctly rejects invalid distribution"
else
    print_fail "Script should reject invalid distribution"
fi

# Test 6: Configuration file exists
print_test "Checking if configuration file exists"
if [ -f "./distro_config.conf" ]; then
    print_pass "Configuration file exists"
else
    print_fail "Configuration file not found"
fi

# Test 7: Documentation exists
print_test "Checking if documentation exists"
if [ -f "./DOWNLOAD_GUIDE.md" ]; then
    print_pass "Documentation file exists"
else
    print_fail "Documentation file not found"
fi

# Test 8: .gitignore exists and excludes ISOs
print_test "Checking if .gitignore exists and excludes ISOs"
if [ -f "./.gitignore" ] && grep -q "\.iso" "./.gitignore"; then
    print_pass ".gitignore exists and excludes ISO files"
else
    print_fail ".gitignore not found or doesn't exclude ISOs"
fi

# Test 9: Script has proper shebang
print_test "Checking script shebang"
if head -1 "./download_distros.sh" | grep -q "^#!/bin/bash"; then
    print_pass "Script has proper bash shebang"
else
    print_fail "Script missing proper shebang"
fi

# Test 10: Script contains checksum verification function
print_test "Checking for checksum verification function"
if grep -q "verify_checksum" "./download_distros.sh"; then
    print_pass "Script contains checksum verification function"
else
    print_fail "Script missing checksum verification function"
fi

# Test 11: Script supports all required distributions
print_test "Checking support for required distributions"
REQUIRED_DISTROS=("ubuntu" "debian" "fedora" "rocky" "arch" "mint")
ALL_SUPPORTED=true
for distro in "${REQUIRED_DISTROS[@]}"; do
    if ! grep -q "download_${distro}" "./download_distros.sh"; then
        print_fail "Missing support for $distro"
        ALL_SUPPORTED=false
    fi
done
if [ "$ALL_SUPPORTED" = true ]; then
    print_pass "All required distributions are supported"
fi

# Test 12: Script has dependency checking
print_test "Checking for dependency verification"
if grep -q "check_dependencies" "./download_distros.sh"; then
    print_pass "Script has dependency checking"
else
    print_fail "Script missing dependency checking"
fi

# Test 13: Script has colored output functions
print_test "Checking for colored output functions"
if grep -q "print_success\|print_error\|print_info" "./download_distros.sh"; then
    print_pass "Script has colored output functions"
else
    print_fail "Script missing colored output functions"
fi

# Test 14: Script supports custom output directory
print_test "Checking for custom output directory support"
if grep -q "\-o.*output" "./download_distros.sh"; then
    print_pass "Script supports custom output directory"
else
    print_fail "Script missing custom output directory support"
fi

# Test 15: Script supports downloading all distributions
print_test "Checking for download all option"
if grep -q "\-a.*all" "./download_distros.sh"; then
    print_pass "Script supports downloading all distributions"
else
    print_fail "Script missing download all option"
fi

echo ""
echo "Test Results:"
echo "============="
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed!${NC}"
    exit 1
fi
