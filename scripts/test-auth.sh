#!/bin/bash

###########################################
# Authentication Test Script
# Tests all authentication endpoints:
# - CSRF token retrieval
# - User registration
# - Login
# - Logout
#
# Usage: ./scripts/test-auth.sh
###########################################

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BLUE='\033[0;34m'

# Configuration
AUTH_URL="http://localhost:3001"
TEST_EMAIL="test@example.com"
TEST_PASSWORD="TestPassword123"
TEST_NAME="Test User"
COOKIE_FILE="scripts/cookies.txt"

echo -e "${BLUE}🔒 Testing Authentication System${NC}\n"

# Create or clear cookies file
mkdir -p scripts
> $COOKIE_FILE

# Step 1: Get CSRF Token
echo -e "${GREEN}1. Getting CSRF Token...${NC}"
CSRF_RESPONSE=$(curl -s -c $COOKIE_FILE -b $COOKIE_FILE $AUTH_URL/csrf-token)
CSRF_TOKEN=$(echo $CSRF_RESPONSE | grep -o '"csrfToken":"[^"]*' | cut -d'"' -f4)

if [ -z "$CSRF_TOKEN" ]; then
    echo -e "${RED}Failed to get CSRF token. Is the server running?${NC}"
    exit 1
fi

echo -e "CSRF Token: $CSRF_TOKEN\n"

# Step 2: Register
echo -e "${GREEN}2. Registering new user...${NC}"
curl -v -X POST \
    -c $COOKIE_FILE -b $COOKIE_FILE \
    -H "Content-Type: application/json" \
    -H "X-CSRF-Token: $CSRF_TOKEN" \
    -d "{\"email\":\"$TEST_EMAIL\",\"password\":\"$TEST_PASSWORD\",\"name\":\"$TEST_NAME\"}" \
    $AUTH_URL/auth/register
echo -e "\n"

# Get new CSRF token for login
CSRF_RESPONSE=$(curl -s -c $COOKIE_FILE -b $COOKIE_FILE $AUTH_URL/csrf-token)
CSRF_TOKEN=$(echo $CSRF_RESPONSE | grep -o '"csrfToken":"[^"]*' | cut -d'"' -f4)

# Step 3: Login
echo -e "${GREEN}3. Logging in...${NC}"
curl -v -X POST \
    -c $COOKIE_FILE -b $COOKIE_FILE \
    -H "Content-Type: application/json" \
    -H "X-CSRF-Token: $CSRF_TOKEN" \
    -d "{\"email\":\"$TEST_EMAIL\",\"password\":\"$TEST_PASSWORD\"}" \
    $AUTH_URL/auth/login
echo -e "\n"

# Get new CSRF token for logout
CSRF_RESPONSE=$(curl -s -c $COOKIE_FILE -b $COOKIE_FILE $AUTH_URL/csrf-token)
CSRF_TOKEN=$(echo $CSRF_RESPONSE | grep -o '"csrfToken":"[^"]*' | cut -d'"' -f4)

# Step 4: Logout
echo -e "${GREEN}4. Logging out...${NC}"
curl -v -X POST \
    -c $COOKIE_FILE -b $COOKIE_FILE \
    -H "Content-Type: application/json" \
    -H "X-CSRF-Token: $CSRF_TOKEN" \
    $AUTH_URL/auth/logout
echo -e "\n"

echo -e "${BLUE}✅ Test complete!${NC}"

# Cleanup
rm -f $COOKIE_FILE 