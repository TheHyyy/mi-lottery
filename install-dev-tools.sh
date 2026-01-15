#!/bin/bash

# 前端开发环境安装脚本（使用国内镜像源）
# 适用于 macOS 系统

echo "======================================"
echo "前端开发环境自动安装脚本"
echo "======================================"
echo ""

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. 检查并安装 Homebrew
echo -e "${YELLOW}步骤 1: 检查 Homebrew...${NC}"
if ! command -v brew &> /dev/null; then
    echo "Homebrew 未安装，开始安装..."
    
    # 设置清华源
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
    
    # 安装 Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # 添加 Homebrew 到 PATH（根据芯片类型）
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    
    echo -e "${GREEN}✓ Homebrew 安装完成${NC}"
else
    echo -e "${GREEN}✓ Homebrew 已安装${NC}"
fi

# 配置 Homebrew 使用清华源
echo -e "${YELLOW}配置 Homebrew 镜像源...${NC}"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

# 将配置写入 shell 配置文件
cat >> ~/.zshrc << 'EOF'

# Homebrew 清华镜像源
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
EOF

echo ""
echo -e "${YELLOW}步骤 2: 安装 Git...${NC}"
if ! command -v git &> /dev/null; then
    brew install git
    echo -e "${GREEN}✓ Git 安装完成${NC}"
else
    echo -e "${GREEN}✓ Git 已安装 ($(git --version))${NC}"
fi

echo ""
echo -e "${YELLOW}步骤 3: 安装 Node.js (LTS版本)...${NC}"
if ! command -v node &> /dev/null; then
    brew install node
    echo -e "${GREEN}✓ Node.js 安装完成${NC}"
else
    echo -e "${GREEN}✓ Node.js 已安装 ($(node --version))${NC}"
fi

echo ""
echo -e "${YELLOW}步骤 4: 配置 npm 使用淘宝镜像源...${NC}"
if command -v npm &> /dev/null; then
    npm config set registry https://registry.npmmirror.com
    echo -e "${GREEN}✓ npm 镜像源配置完成${NC}"
fi

echo ""
echo -e "${YELLOW}步骤 5: 安装 pnpm...${NC}"
if ! command -v pnpm &> /dev/null; then
    npm install -g pnpm
    echo -e "${GREEN}✓ pnpm 安装完成${NC}"
else
    echo -e "${GREEN}✓ pnpm 已安装 ($(pnpm --version))${NC}"
fi

# 配置 pnpm 使用淘宝镜像
pnpm config set registry https://registry.npmmirror.com

echo ""
echo -e "${YELLOW}步骤 6: 安装 Yarn...${NC}"
if ! command -v yarn &> /dev/null; then
    npm install -g yarn
    yarn config set registry https://registry.npmmirror.com
    echo -e "${GREEN}✓ Yarn 安装完成${NC}"
else
    echo -e "${GREEN}✓ Yarn 已安装 ($(yarn --version))${NC}"
fi

echo ""
echo -e "${YELLOW}步骤 7: 安装常用全局工具...${NC}"

# TypeScript
if ! command -v tsc &> /dev/null; then
    npm install -g typescript
    echo -e "${GREEN}✓ TypeScript 安装完成${NC}"
else
    echo -e "${GREEN}✓ TypeScript 已安装 ($(tsc --version))${NC}"
fi

# ts-node
if ! command -v ts-node &> /dev/null; then
    npm install -g ts-node
    echo -e "${GREEN}✓ ts-node 安装完成${NC}"
else
    echo -e "${GREEN}✓ ts-node 已安装${NC}"
fi

# ESLint
if ! command -v eslint &> /dev/null; then
    npm install -g eslint
    echo -e "${GREEN}✓ ESLint 安装完成${NC}"
else
    echo -e "${GREEN}✓ ESLint 已安装${NC}"
fi

# Prettier
if ! command -v prettier &> /dev/null; then
    npm install -g prettier
    echo -e "${GREEN}✓ Prettier 安装完成${NC}"
else
    echo -e "${GREEN}✓ Prettier 已安装${NC}"
fi

# Vue CLI
if ! command -v vue &> /dev/null; then
    npm install -g @vue/cli
    echo -e "${GREEN}✓ Vue CLI 安装完成${NC}"
else
    echo -e "${GREEN}✓ Vue CLI 已安装${NC}"
fi

# Vite
if ! command -v vite &> /dev/null; then
    npm install -g vite
    echo -e "${GREEN}✓ Vite 安装完成${NC}"
else
    echo -e "${GREEN}✓ Vite 已安装${NC}"
fi

# http-server (本地静态服务器)
if ! command -v http-server &> /dev/null; then
    npm install -g http-server
    echo -e "${GREEN}✓ http-server 安装完成${NC}"
else
    echo -e "${GREEN}✓ http-server 已安装${NC}"
fi

# serve (另一个静态服务器工具)
if ! command -v serve &> /dev/null; then
    npm install -g serve
    echo -e "${GREEN}✓ serve 安装完成${NC}"
else
    echo -e "${GREEN}✓ serve 已安装${NC}"
fi

# ni - 智能包管理器
npm install -g @antfu/ni

echo ""
echo -e "${YELLOW}步骤 8: 安装其他开发工具...${NC}"

# 安装 wget
if ! command -v wget &> /dev/null; then
    brew install wget
    echo -e "${GREEN}✓ wget 安装完成${NC}"
else
    echo -e "${GREEN}✓ wget 已安装${NC}"
fi

# 安装 tree (目录树查看)
if ! command -v tree &> /dev/null; then
    brew install tree
    echo -e "${GREEN}✓ tree 安装完成${NC}"
else
    echo -e "${GREEN}✓ tree 已安装${NC}"
fi

# 安装 jq (JSON 处理工具)
if ! command -v jq &> /dev/null; then
    brew install jq
    echo -e "${GREEN}✓ jq 安装完成${NC}"
else
    echo -e "${GREEN}✓ jq 已安装${NC}"
fi

echo ""
echo "======================================"
echo -e "${GREEN}🎉 所有工具安装完成！${NC}"
echo "======================================"
echo ""
echo "已安装的工具版本："
echo "-------------------"
echo "Homebrew: $(brew --version | head -n 1)"
echo "Git:      $(git --version)"
echo "Node.js:  $(node --version)"
echo "npm:      $(npm --version)"
echo "pnpm:     $(pnpm --version)"
echo "yarn:     $(yarn --version)"
echo ""
echo "已配置的镜像源："
echo "-------------------"
echo "npm:  $(npm config get registry)"
echo "pnpm: $(pnpm config get registry)"
echo "yarn: $(yarn config get registry)"
echo ""
echo -e "${YELLOW}提示：${NC}"
echo "1. 请重启终端或执行 'source ~/.zshrc' 使环境变量生效"
echo "2. 所有工具已配置国内镜像源，下载速度会更快"
echo "3. 如需切换 Node.js 版本，建议安装 nvm: brew install nvm"
echo ""
