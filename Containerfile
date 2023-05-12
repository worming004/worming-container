FROM quay.io/fedora/fedora

RUN dnf install -y git
RUN dnf install -y ripgrep
RUN dnf install -y fd-find
RUN dnf install -y unzip
RUN dnf install -y wget
RUN dnf install -y gcc
RUN dnf install -y npm

WORKDIR /root
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
RUN echo ". "$HOME/.asdf/asdf.sh"" >> .bashrc
RUN echo ". "$HOME/.asdf/completions/asdf.bash"" >> .bashrc

RUN source ~/.bashrc
ENV PATH="${PATH}:/root/.asdf/shims:/root/.asdf/bin"

COPY ./asdf.sh asdf.sh
RUN ./asdf.sh golang 1.20.4
RUN ./asdf.sh neovim 0.9.0
RUN ./asdf.sh lazygit 0.38.2

RUN mkdir ~/.config
RUN git clone https://github.com/worming004/nvim-ide --branch master ~/.config/nvim

# try latter to make tmux work in it
# RUN dnf install -y tmux
# RUN dnf install -y openssh-server
# RUN systemctl start sshd.servce
# RUN tmux new -s mysesh

RUN mkdir workdir
WORKDIR /root/workdir
CMD ["nvim"]
