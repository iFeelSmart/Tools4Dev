ARG FEDORA_VERSION=34
ARG T4D_FINAL_VERSION_SUFFIX=""
ARG T4D_BRANCH=develop
FROM fedora:${FEDORA_VERSION} AS t4d-ifeelsmart


RUN dnf install -y zsh hostname util-linux-user jq git findutils libplist

WORKDIR /root
RUN bash -c "T4D_NATIVE=false SKIP_T4D_CLONE=true T4D_BRANCH=${T4D_BRANCH} $(curl -fsSL https://raw.githubusercontent.com/T4D-Suites/Tools4Dev/develop/Platforms/install.sh)"

WORKDIR /root/.tools4dev
RUN cat src/VERSION | sed "s|\$|${T4D_FINAL_VERSION_SUFFIX}|g" > src/VERSION
RUN tar -cvf tools4dev.tar src completions init bin .zshrc

