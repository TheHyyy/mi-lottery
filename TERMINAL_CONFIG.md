# iTerm + Zsh 配置说明

## ✅ 已配置完成

### 1. Oh My Zsh
已安装 Oh My Zsh 框架，提供更强大的 zsh 功能和美化。

### 2. 启用的插件
- **git** - Git 命令别名和补全
- **node** - Node.js 相关补全
- **npm** - npm 命令补全
- **yarn** - Yarn 命令补全
- **vscode** - VS Code 快捷命令
- **z** - 智能目录跳转（记住常用目录）
- **sudo** - 按两次 ESC 自动添加 sudo
- **colored-man-pages** - 彩色 man 手册
- **extract** - 智能解压各种压缩包（`x 文件名`）

### 3. 配置的环境变量
- **NVM** - Node.js 版本管理器自动加载
- npm/pnpm/yarn 都已配置淘宝镜像源

## 📝 可用的命令别名

### 通用别名
```bash
cls          # 清屏（等同于 clear）
ll           # 详细列表（ls -lah）
..           # 返回上级目录
...          # 返回上两级目录
```

### Git 别名
```bash
gs           # git status
ga           # git add
gc           # git commit
gp           # git push
gl           # git pull
glog         # git log --oneline --graph --decorate（图形化日志）
```

### pnpm 快捷命令
```bash
pi           # pnpm install
pd           # pnpm dev
pb           # pnpm build
pt           # pnpm test
```

### Oh My Zsh Git 插件自带别名
```bash
gst          # git status
gaa          # git add --all
gcmsg        # git commit -m
ggpush       # git push origin 当前分支
ggpull       # git pull origin 当前分支
gco          # git checkout
gcb          # git checkout -b（创建新分支）
gd           # git diff
glog         # git log --oneline --decorate --graph
```

## 🚀 实用技巧

### 1. z 命令（智能跳转）
访问过的目录会被记住，之后可以快速跳转：
```bash
# 假设之前访问过 /Users/houyu/Desktop/project/log-lottery
z lottery        # 直接跳转到该目录
z proj          # 模糊匹配跳转
```

### 2. extract 命令（智能解压）
```bash
x filename.zip      # 自动识别格式并解压
x filename.tar.gz
x filename.rar
```

### 3. 双击 ESC 添加 sudo
输入命令后，如果忘记加 sudo，按两次 ESC 自动添加。

### 4. Tab 自动补全
- 文件名、目录名补全
- Git 分支名补全
- npm/yarn/pnpm 命令和包名补全

## 🎨 进一步美化（可选）

### 安装更酷的主题 - Powerlevel10k
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

然后修改 `~/.zshrc` 中的：
```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

重新打开终端，会自动引导配置。

### 安装语法高亮插件
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### 安装自动建议插件
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

然后在 `~/.zshrc` 的 plugins 中添加：
```bash
plugins=(git node npm yarn vscode z sudo colored-man-pages extract zsh-syntax-highlighting zsh-autosuggestions)
```

执行 `source ~/.zshrc` 生效。

## 📖 查看所有可用别名
```bash
alias                    # 查看所有别名
alias | grep git         # 查看所有 git 相关别名
```

## 🔧 自定义配置
编辑配置文件：
```bash
code ~/.zshrc           # 使用 VS Code 编辑
vim ~/.zshrc            # 使用 vim 编辑
```

修改后执行生效：
```bash
source ~/.zshrc
```

---

**提示：** 所有配置都已经生效，关闭并重新打开终端即可使用所有功能！
