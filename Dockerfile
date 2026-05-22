FROM mcr.microsoft.com/playwright/dotnet:v1.60.0-noble

WORKDIR /app

RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    curl -sL https://deb.nodesource.com/setup_22.x -o /tmp/nodesource_setup.sh && \
    bash /tmp/nodesource_setup.sh && \
    rm /tmp/nodesource_setup.sh && \
    apt update && \
    apt install -y --no-install-recommends nodejs openssl docker-ce-cli && \
    apt clean && \
    npm install -D tailwindcss@^4 && \
    npm install -g pnpm && \
    rm -rf /var/lib/apt/lists/*

COPY . .
