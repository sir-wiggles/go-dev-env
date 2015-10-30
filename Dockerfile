FROM ubuntu:15.10

MAINTAINER Jeff Gregory <jeffmgreg@gmail.com>

RUN apt-get update && apt-get install -y \
	ack-grep bzr cmake     \
	curl g++ git make      \
	man-db mercurial       \
	ncurses-dev nodejs     \
	npm procps python-dev  \
	python-pip ssh         \
	sudo unzip vim         \
	xz-utils ipython

RUN rm -rf /var/lib/apt/lists/*

#RUN ln -s /usr/bin/nodejs /usr/bin/node && npm install -g bower grunt-cli

# ========================================================================
# ----------------
# Install GO 1.4.3
# ----------------

RUN mkdir /installs

RUN cd /installs && wget https://storage.googleapis.com/golang/go1.4.3.src.tar.gz && tar -xf go1.4.3.src.tar.gz

# because of a bug in... Docker? Running a net test as root for ipv4:icmp will fail
ADD patch1.4.3 /installs/
RUN patch /installs/go/src/net/file_test.go < /installs/patch1.4.3

RUN cd /installs/go/src && ./all.bash

ENV GOPATH /go
ENV GOBIN /go/bin
ENV PATH /installs/go/bin:/go/bin:$PATH
ENV HOME /root

# ========================================================================
# ---------
# VIM Setup
# ---------

# Vundle: Vim plugin manager
RUN git clone https://github.com/gmarik/Vundle.vim.git /root/.vim/bundle/Vundle.vim
RUN git clone https://github.com/Valloric/YouCompleteMe.git /root/.vim/bundle/YouCompleteMe
RUN cd /root/.vim/bundle/YouCompleteMe          && \
	git submodule update --init --recursive && \
 	./install.sh --clang-completer

COPY vimrc /root/.vimrc
RUN vim +PluginInstall  +qall
RUN vim +GoInstallBinaries +qall
# ========================================================================

# Change timezone
RUN ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
COPY bashrc /root/.bashrc

WORKDIR /go/src
CMD ["/bin/bash"]

# Run Docker with
# sudo docker run -i -t -v ~/workspace/src:/go/src testing2
