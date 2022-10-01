FROM ubuntu:kinetic AS step1

WORKDIR /toolchain
RUN apt -y update && apt -y install curl zstd tar
RUN curl -Lo clang.tar.zst https://github.com/Neutron-Toolchains/clang-build-catalogue/releases/download/01102022/neutron-clang-01102022.tar.zst && tar -I zstd -xf clang.tar.zst && rm -rf clang.tar.zst && \
rm -rf .git share tc/lib/cmake lib/clang/16.0.0/lib/i386-unknown-linux-gnu lib/clang/16.0.0/lib/x86_64-unknown-linux-gnu && \
rm -f lib/LLVMgold.so lib/LLVMPolly.so bin/clang-16.org lib/libclang-cpp.so.16git lib/libLTO.so.16git 


FROM ubuntu:kinetic 

USER root

WORKDIR /root

COPY --from=step1 /toolchain /root/tc

RUN apt -y autoclean && apt -y clean && apt -y autoremove && \
rm -rf /usr/share/man

ENV GIT_SSL_NO_VERIFY=true

ENV LLVM_DIR=/root/tc/bin
