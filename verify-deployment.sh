#!/bin/bash

# 🎯 AUTOMATED DEPLOYMENT VERIFICATION SCRIPT
# This script checks if your deployment is configured correctly

echo "=========================================="
echo "🔍 DEPLOYMENT VERIFICATION SCRIPT"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check Docker
echo "1️⃣  Checking Docker..."
if command -v docker &> /dev/null; then
    echo -e "${GREEN}✅ Docker is installed${NC}"
    docker --version
else
    echo -e "${RED}❌ Docker is NOT installed${NC}"
    echo "   Install from: https://www.docker.com/get-started"
fi
echo ""

# Check Docker Compose
echo "2️⃣  Checking Docker Compose..."
if command -v docker-compose &> /dev/null; then
    echo -e "${GREEN}✅ Docker Compose is installed${NC}"
    docker-compose --version
else
    echo -e "${RED}❌ Docker Compose is NOT installed${NC}"
fi
echo ""

# Check Git
echo "3️⃣  Checking Git status..."
if [ -d .git ]; then
    echo -e "${GREEN}✅ Git repository initialized${NC}"
    
    # Check for uncommitted changes
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "${YELLOW}⚠️  You have uncommitted changes${NC}"
        echo "   Run: git add . && git commit -m 'Ready for deployment' && git push"
    else
        echo -e "${GREEN}✅ No uncommitted changes${NC}"
    fi
else
    echo -e "${RED}❌ Not a git repository${NC}"
fi
echo ""

# Check required files
echo "4️⃣  Checking required files..."

files=("Dockerfile" "docker-compose.yml" ".env" ".gitignore" "backend/pom.xml" "frontend/package.json")

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ $file exists${NC}"
    else
        echo -e "${RED}❌ $file is missing${NC}"
    fi
done
echo ""

# Check Dockerfile
echo "5️⃣  Checking Dockerfile configuration..."
if grep -q "PORT" Dockerfile; then
    echo -e "${GREEN}✅ Dockerfile has PORT configuration${NC}"
else
    echo -e "${YELLOW}⚠️  Dockerfile might be missing PORT configuration${NC}"
fi
echo ""

# Check .env file
echo "6️⃣  Checking .env configuration..."
if [ -f .env ]; then
    if grep -q "DB_URL" .env; then
        echo -e "${GREEN}✅ DB_URL is configured${NC}"
    else
        echo -e "${RED}❌ DB_URL is missing in .env${NC}"
    fi
    
    if grep -q "DB_USER" .env; then
        echo -e "${GREEN}✅ DB_USER is configured${NC}"
    else
        echo -e "${RED}❌ DB_USER is missing in .env${NC}"
    fi
    
    if grep -q "DB_PASS" .env; then
        echo -e "${GREEN}✅ DB_PASS is configured${NC}"
    else
        echo -e "${RED}❌ DB_PASS is missing in .env${NC}"
    fi
fi
echo ""

# Check if .env is in .gitignore
echo "7️⃣  Checking .gitignore..."
if grep -q "^\.env$" .gitignore; then
    echo -e "${GREEN}✅ .env is in .gitignore (GOOD - don't commit secrets!)${NC}"
else
    echo -e "${YELLOW}⚠️  .env should be in .gitignore${NC}"
fi
echo ""

# Try to build Docker image
echo "8️⃣  Testing Docker build (this may take a few minutes)..."
echo "   Building Docker image..."

if docker build -t sms-test . > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Docker build successful!${NC}"
    
    # Get image size
    IMAGE_SIZE=$(docker images sms-test --format "{{.Size}}")
    echo "   Image size: $IMAGE_SIZE"
    
    # Cleanup
    docker rmi sms-test > /dev/null 2>&1
else
    echo -e "${RED}❌ Docker build failed${NC}"
    echo "   Run 'docker build .' to see detailed errors"
fi
echo ""

# Check ports
echo "9️⃣  Checking if ports are available..."

check_port() {
    if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
        echo -e "${YELLOW}⚠️  Port $1 is already in use${NC}"
        lsof -Pi :$1 -sTCP:LISTEN -t | xargs ps -p
    else
        echo -e "${GREEN}✅ Port $1 is available${NC}"
    fi
}

check_port 3306
check_port 8080
echo ""

# Final recommendations
echo "=========================================="
echo "📋 DEPLOYMENT READINESS SUMMARY"
echo "=========================================="
echo ""
echo "🎯 NEXT STEPS:"
echo ""
echo "1. Commit and push your code:"
echo "   git add ."
echo "   git commit -m 'Ready for deployment'"
echo "   git push"
echo ""
echo "2. Deploy on Render:"
echo "   - Go to https://dashboard.render.com/"
echo "   - Create Web Service from your GitHub repo"
echo "   - Set environment variables (see RENDER_ENV_VARIABLES.md)"
echo ""
echo "3. Update frontend:"
echo "   - Add backend URL to Vercel environment variables"
echo "   - Redeploy frontend"
echo ""
echo "4. Test your application:"
echo "   - Try logging in"
echo "   - Add/view/edit students"
echo ""
echo "=========================================="
echo "📚 DOCUMENTATION:"
echo "=========================================="
echo ""
echo "- DEPLOYMENT_GUIDE.md - Complete deployment steps"
echo "- LOCAL_DEVELOPMENT.md - Running locally with Docker"
echo "- RENDER_ENV_VARIABLES.md - Environment variables reference"
echo ""
echo "=========================================="
echo "✅ VERIFICATION COMPLETE!"
echo "=========================================="
