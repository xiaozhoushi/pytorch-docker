#!/bin/bash
ARG BASE_IMAGE

FROM ${BASE_IMAGE}
LABEL maintainer shixiaozhou0913@gmail.com
LABEL version = "1.0.0"
LABEL description = "pytorch docker images"

ENV PASSWOED 123
EXPOSE 8888

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y \
        wget build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
        libreadline-dev libffi-dev libsqlite3-dev libbz2-dev liblzma-dev git curl && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    git clone https://github.com/xiaozhoushi/dotfiles.git .config && \
    echo "update source..." && \
    apt update && \
    which pip3 >/dev/null && echo "pip installed, moving on..." || apt install -y python3-pip >/dev/null && \
    which node >/dev/null && echo "node installed, moving on..." || apt install -y nodejs && \
    apt install -y npm && \
    mkdir ~/.npm-global && \
    npm config set prefix '~/.npm-global' && \
    apt install -y tmux ranger && \
    echo "install zsh..." && \
    apt install -y zsh && \
    echo "install font..." && \
    apt install fonts-firacode && \
    echo "install ohmyzsh..." && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    ln -s -f ~/.config/.zshrc ~/.zshrc && \
    apt install -y bat fd-find ripgrep fzf libjpeg8-dev zlib1g-dev libxtst-dev \
      python-dev python3-dev net-tools thefuck expect && \
    echo "install neovim..." && \
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    ./squashfs-root/AppRun --version && \
    ln -s -f /squashfs-root/AppRun /usr/bin/nvim && \
    rm -rf nvim.appimage && \
    mkdir install_file

COPY install_file/* install_file/

ARG DEBIAN_FRONTEND=noninteractive
RUN echo "install tree-sitter ..." && \
    npm install -g tree-sitter-cli --ignore-scripts && \
    pip3 install pynvim -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com && \
    curl --proto '=https' --tlsv1.3 -sSf https://sh.rustup.rs >> install_file/rustup.sh && \
    expect install_file/install_rustup.exp && \
    rm install_file/rustup.sh && \
    echo "install lazygit..." && \
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar xf lazygit.tar.gz lazygit && \
    install lazygit /usr/local/bin && \
    rm lazygit* && \
    echo "install tmux..." && \
    git clone https://github.com/gpakosz/.tmux.git ~/.config/.tmux && \
    cp ~/.config/.tmux/.tmux.conf ~/.config/.tmux.conf && \
    ln -s -f ~/.config/.tmux.conf ~/.tmux.conf && \
    cp ~/.config/.tmux/.tmux.conf.local ~/.tmux.conf.local && \
    rm -rf ~/.config/.tmux

ARG DEBIAN_FRONTEND=noninteractive
ARG CONDA_VERSION
ARG CUDA_VERSION
RUN echo "install anaconda..." && \
    exec bash && \
    wget https://repo.anaconda.com/archive/Anaconda3-${CONDA_VERSION}-Linux-x86_64.sh && \
    sh Anaconda3-${CONDA_VERSION}-Linux-x86_64.sh -b && \
    source ~/anaconda3/bin && \
    expect install_file/install_pytorch.exp ${CUDA_VERSION} && \
    #echo "install lunarvim..." && \
    #LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh) && \
    #mv ~/.config/lvim lvim.new && \
    #mv ~/.config/lvim.old lvim && \
    rm Anaconda3-${CONDA_VERSION}-Linux-x86_64.sh && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -r /root/.cache/pip

WORKDIR /workspace
