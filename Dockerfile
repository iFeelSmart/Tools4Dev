ARG FEDORA_VERSION=34
FROM fedora:${FEDORA_VERSION} AS t4d-ifeelsmart

RUN dnf install -y zsh hostname util-linux-user jq git findutils libplist

WORKDIR /root
RUN bash -c "SKIP_T4D_CLONE=true T4D_BRANCH=develop $(curl -fsSL https://raw.githubusercontent.com/T4D-Suites/Tools4Dev/develop/Platforms/install.sh)"

WORKDIR /root/.tools4dev
RUN tar -cvf tools4dev.tar src 

