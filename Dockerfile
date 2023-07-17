ARG FEDORA_VERSION=34
FROM fedora:${FEDORA_VERSION} AS t4d-ifeelsmart

ARG T4D_FINAL_VERSION_SUFFIX
ARG T4D_BRANCH=develop

RUN dnf install -y zsh hostname util-linux-user jq git findutils libplist

WORKDIR /root
RUN bash -c "T4D_NATIVE=false SKIP_T4D_CLONE=true T4D_VERSION_SUFFIX=${T4D_FINAL_VERSION_SUFFIX} T4D_BRANCH=${T4D_BRANCH} $(curl -fsSL https://raw.githubusercontent.com/T4D-Suites/Tools4Dev/develop/Platforms/install.sh)"

WORKDIR /root/.tools4dev
# Clean .git repo if exist 
RUN mkdir -p "src-devel/.git"
RUN rm -rf "src-devel/.git"

# Generating src-lts folder
RUN mv "src-devel" "src-lts"
RUN ln -sfvn "src-lts" "src"

# Creating Archive
RUN tar -cvf tools4dev.tar src-lts bin completions team init src manifest.xml


