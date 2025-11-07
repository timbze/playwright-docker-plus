FROM mcr.microsoft.com/playwright/dotnet:v1.55.0-noble

WORKDIR /app

RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    curl -sL https://deb.nodesource.com/setup_18.x -o /tmp/nodesource_setup.sh && \
    # install dotnet 10.0 (eventually playwright will likely support dotnet 10.0)
    curl -sSL https://raw.githubusercontent.com/dotnet/install-scripts/refs/heads/main/src/dotnet-install.sh | bash -s -- --install-dir /usr/share/dotnet --channel 10.0 && \
    bash /tmp/nodesource_setup.sh && \
    rm /tmp/nodesource_setup.sh && \
    apt update && \
    apt install -y --no-install-recommends nodejs openssl docker-ce-cli && \
    apt clean && \
    npm install -D tailwindcss@^4 && \
    rm -rf /var/lib/apt/lists/*

COPY . .
