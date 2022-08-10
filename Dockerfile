FROM archlinux:latest

USER root

WORKDIR /root

RUN pacman -Syyu --needed --noconfirm git && git clone --depth 1 https://gitlab.com/dakkshesh07/neutron-clang.git tc

ENV LLVM_DIR=/root/tc/bin
