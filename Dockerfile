FROM mcr.microsoft.com/playwright/dotnet:v1.63.0-noble

WORKDIR /app

# Optional extra .NET SDK (e.g. 11.0 preview) installed next to the one in the base image.
ARG DOTNET_CHANNEL=
ARG DOTNET_QUALITY=

RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    curl -sL https://deb.nodesource.com/setup_26.x -o /tmp/nodesource_setup.sh && \
    bash /tmp/nodesource_setup.sh && \
    rm /tmp/nodesource_setup.sh && \
    apt update && \
    apt install -y --no-install-recommends nodejs openssl docker-ce-cli && \
    apt clean && \
    npm install -D tailwindcss@^4 && \
    npm install -g pnpm && \
    rm -rf /var/lib/apt/lists/* && \
    if [ -n "$DOTNET_CHANNEL" ]; then \
      curl -sSL https://raw.githubusercontent.com/dotnet/install-scripts/refs/heads/main/src/dotnet-install.sh | \
        bash -s -- --install-dir /usr/share/dotnet --channel "$DOTNET_CHANNEL" ${DOTNET_QUALITY:+--quality "$DOTNET_QUALITY"}; \
    fi

COPY . .
