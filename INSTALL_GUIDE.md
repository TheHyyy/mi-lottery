# 前端开发环境安装指南（macOS）

## 使用国内镜像源加速

本指南将帮助你在 macOS 上安装完整的前端开发环境，所有工具都配置了国内镜像源。

---

## 方式一：自动安装（推荐）

### 1. 打开终端，执行以下命令：

```bash
cd /Users/houyu/Desktop/project/log-lottery
chmod +x install-dev-tools.sh
./install-dev-tools.sh
```

这个脚本会自动完成所有安装和配置。

---

## 方式二：手动安装

如果自动脚本遇到问题，可以按照以下步骤手动安装：

### 1. 安装 Homebrew（使用清华镜像）

```bash
# 设置环境变量
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

# 安装 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**注意：** 安装过程中会要求输入系统密码（就是你登录 Mac 的密码），输入时不会显示任何字符，输入完直接按回车即可。

### 2. 配置 Homebrew 环境变量

根据你的 Mac 芯片类型选择：

**Apple Silicon (M1/M2/M3)：**
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

**Intel 芯片：**
```bash
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"
```

### 3. 将 Homebrew 镜像配置写入 shell 配置文件

```bash
cat >> ~/.zshrc << 'EOF'

# Homebrew 清华镜像源
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
EOF
```

### 4. 使配置生效

```bash
source ~/.zshrc
```

### 5. 安装 Git

```bash
brew install git
```

### 6. 安装 Node.js (LTS版本)

```bash
brew install node
```

### 7. 配置 npm 使用淘宝镜像

```bash
npm config set registry https://registry.npmmirror.com
```

验证配置：
```bash
npm config get registry
# 应该输出：https://registry.npmmirror.com/
```

### 8. 安装 pnpm

```bash
npm install -g pnpm
```

配置 pnpm 镜像：
```bash
pnpm config set registry https://registry.npmmirror.com
```

### 9. 安装 Yarn

```bash
npm install -g yarn
yarn config set registry https://registry.npmmirror.com
```

### 10. 安装常用全局工具

```bash
# TypeScript
npm install -g typescript

# ts-node (运行 TypeScript 文件)
npm install -g ts-node

# ESLint (代码检查)
npm install -g eslint

# Prettier (代码格式化)
npm install -g prettier

# Vue CLI
npm install -g @vue/cli

# Vite
npm install -g vite

# http-server (本地静态服务器)
npm install -g http-server

# serve (另一个静态服务器)
npm install -g serve

# ni (智能包管理器，自动识别 npm/yarn/pnpm)
npm install -g @antfu/ni
```

### 11. 安装其他有用的工具

```bash
# wget (下载工具)
brew install wget

# tree (查看目录树)
brew install tree

# jq (JSON 处理工具)
brew install jq
```

---

## 验证安装

运行以下命令验证所有工具是否安装成功：

```bash
# 查看版本
brew --version
git --version
node --version
npm --version
pnpm --version
yarn --version
tsc --version

# 查看镜像源配置
echo "npm registry: $(npm config get registry)"
echo "pnpm registry: $(pnpm config get registry)"
echo "yarn registry: $(yarn config get registry)"
```

---

## 可选：安装 nvm (Node.js 版本管理器)

如果你需要在不同的 Node.js 版本之间切换：

```bash
brew install nvm

# 添加到配置文件
mkdir -p ~/.nvm
cat >> ~/.zshrc << 'EOF'

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
EOF

# 使配置生效
source ~/.zshrc
```

使用 nvm：
```bash
# 列出可用版本
nvm list-remote

# 安装 LTS 版本
nvm install --lts

# 切换版本
nvm use 18
```

---

## 可选：安装其他前端工具

```bash
# Create React App
npm install -g create-react-app

# Next.js CLI
npm install -g create-next-app

# Nuxt CLI
npm install -g create-nuxt-app

# PM2 (进程管理器)
npm install -g pm2

# nodemon (自动重启工具)
npm install -g nodemon

# concurrently (并发运行多个命令)
npm install -g concurrently

# rimraf (跨平台删除工具)
npm install -g rimraf

# npm-check-updates (检查包更新)
npm install -g npm-check-updates
```

---

## 镜像源说明

### npm/pnpm/yarn 镜像源

- **淘宝镜像**：`https://registry.npmmirror.com` （推荐）
- **华为镜像**：`https://repo.huaweicloud.com/repository/npm/`
- **腾讯镜像**：`http://mirrors.cloud.tencent.com/npm/`

切换镜像源：
```bash
npm config set registry https://registry.npmmirror.com
pnpm config set registry https://registry.npmmirror.com
yarn config set registry https://registry.npmmirror.com
```

恢复官方源：
```bash
npm config set registry https://registry.npmjs.org
pnpm config set registry https://registry.npmjs.org
yarn config set registry https://registry.npmjs.org
```

### Homebrew 镜像源

本指南使用的是清华大学的 Homebrew 镜像，也可以选择：

- **中科大镜像**：`https://mirrors.ustc.edu.cn/`
- **阿里云镜像**：`https://mirrors.aliyun.com/`

---

## 故障排除

### 1. Homebrew 安装很慢或失败

- 检查网络连接
- 尝试使用其他镜像源
- 关闭 VPN（如果在使用）

### 2. npm 安装包很慢

- 确认已配置镜像源：`npm config get registry`
- 清除 npm 缓存：`npm cache clean --force`
- 尝试使用 pnpm，速度更快

### 3. 权限错误

```bash
# 修复 npm 权限问题
sudo chown -R $(whoami) ~/.npm
sudo chown -R $(whoami) /usr/local/lib/node_modules
```

### 4. 命令找不到

确保已重启终端或执行：
```bash
source ~/.zshrc
```

---

## 项目依赖安装

现在你可以在项目中安装依赖了：

```bash
cd /Users/houyu/Desktop/project/log-lottery

# 使用 pnpm (推荐，因为项目有 pnpm-lock.yaml)
pnpm install

# 或使用 npm
npm install

# 或使用 yarn
yarn install
```

---

## 常用命令速查

```bash
# 启动项目（根据 package.json 中的脚本）
pnpm dev          # 开发模式
pnpm build        # 构建生产版本
pnpm preview      # 预览构建结果

# 包管理
pnpm add <package>              # 添加依赖
pnpm add -D <package>           # 添加开发依赖
pnpm remove <package>           # 移除依赖
pnpm update                     # 更新依赖
pnpm outdated                   # 查看过时的包

# 查看全局安装的包
npm list -g --depth=0
pnpm list -g --depth=0
```

---

## 推荐的 VS Code 扩展

- **Vue Language Features (Volar)** - Vue 3 支持
- **TypeScript Vue Plugin (Volar)** - Vue 中的 TypeScript 支持
- **ESLint** - 代码检查
- **Prettier** - 代码格式化
- **Auto Import** - 自动导入
- **Path Intellisense** - 路径智能提示
- **GitLens** - Git 增强
- **Error Lens** - 行内错误提示

---

**祝你开发愉快！** 🚀
