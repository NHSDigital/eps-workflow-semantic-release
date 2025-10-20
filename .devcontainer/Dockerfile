FROM mcr.microsoft.com/devcontainers/base:ubuntu

ARG ASDF_VERSION
COPY .tool-versions.asdf /tmp/.tool-versions.asdf

RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y dist-upgrade \
    && apt-get -y install --no-install-recommends htop vim curl git build-essential \
    libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev libbz2-dev \
    zlib1g-dev unixodbc unixodbc-dev libsecret-1-0 libsecret-1-dev libsqlite3-dev \
    jq apt-transport-https ca-certificates gnupg-agent \
    software-properties-common bash-completion python3-pip make libbz2-dev \
    libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev liblzma-dev libyaml-dev pre-commit

# Install ASDF
RUN ASDF_VERSION=$(awk '!/^#/ && NF {print $1; exit}' /tmp/.tool-versions.asdf) && \
    wget -O /tmp/asdf.tar.gz https://github.com/asdf-vm/asdf/releases/download/v${ASDF_VERSION}/asdf-v${ASDF_VERSION}-linux-amd64.tar.gz; \
    tar -xvzf /tmp/asdf.tar.gz; \
    mv asdf /usr/bin
USER vscode


ENV PATH="$PATH:/home/vscode/.asdf/bin/:/workspaces/eps-workflow-semantic-release/node_modules/.bin"

# Install ASDF plugins#
RUN asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git; \
    asdf plugin add shellcheck https://github.com/luizm/asdf-shellcheck.git; \
    asdf plugin add actionlint; \
    asdf plugin add python; \
    asdf plugin add poetry

WORKDIR /workspaces/eps-workflow-semantic-release

ADD .tool-versions /workspaces/eps-workflow-semantic-release/.tool-versions
ADD .tool-versions /home/vscode/.tool-versions

RUN asdf install python; \
    asdf install; \
    asdf reshim nodejs; \
    asdf reshim actionlint;
