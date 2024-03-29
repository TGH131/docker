FROM ubuntu:kinetic AS step1

WORKDIR /toolchain
RUN apt -y update && apt -y install curl zstd tar
RUN curl -Lo clang.tar.zst https://github.com/Neutron-Toolchains/clang-build-catalogue/releases/download/28012023/neutron-clang-28012023.tar.zst && tar -I zstd -xf clang.tar.zst && rm -rf clang.tar.zst && \
rm -rf .git 

FROM archlinux:latest

USER root

WORKDIR /root

COPY --from=step1 /toolchain /root/tc

ENV GIT_SSL_NO_VERIFY=true

ENV PATH="${PATH}:/root/tc/bin/"
