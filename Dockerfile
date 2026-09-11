FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    ffmpeg \
    nodejs \
    npm \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# The packaged native application and yt-dlp binary are committed under docker/.
COPY docker/videodownloader /app/videodownloader
COPY docker/ytdlp /usr/local/bin/ytdlp

RUN chmod +x /app/videodownloader /usr/local/bin/ytdlp \
    && groupadd --system appgroup \
    && useradd --system --gid appgroup appuser

USER appuser
WORKDIR /app

EXPOSE 8080
ENTRYPOINT ["/app/videodownloader"]
