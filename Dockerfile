FROM alpine/git:latest AS step1

WORKDIR /toolchain

RUN git clone --depth 1 https://gitlab.com/dakkshesh07/neutron-clang.git tc && \
rm -rf tc/.git tc/share tc/lib/cmake \
tc/lib/clang/16.0.0/lib/i386-unknown-linux-gnu \
tc/lib/clang/16.0.0/lib/x86_64-unknown-linux-gnu && \
rm -f tc/lib/LLVMgold.so tc/lib/LLVMPolly.so tc/bin/clang-16.org \
tc/lib/libclang-cpp.so.16git tc/lib/libLTO.so.16git 



FROM ubuntu:kinetic 

USER root

WORKDIR /root

COPY --from=step1 /toolchain/tc /root/tc

RUN apt -y autoclean && apt -y clean && apt -y autoremove && \
rm -rf /usr/share/man

ENV GIT_SSL_NO_VERIFY=true

ENV LLVM_DIR=/root/tc/bin
