FROM alpine:3.7

RUN apk add --update ffmpeg python

# youtube-dl installation (python is a run time dependency for this)
ENV YOUTUBE_DL_VERSION=2018.02.04
RUN apk add --update curl && \
    curl -sL https://github.com/rg3/youtube-dl/releases/download/${YOUTUBE_DL_VERSION}/youtube-dl -o /usr/local/bin/youtube-dl && \
    chmod a+rx /usr/local/bin/youtube-dl && \
    apk del curl && rm -rf /var/cache/apk/*

WORKDIR /output

CMD youtube-dl --extract-audio --audio-format mp3 --prefer-ffmpeg -f 140 -a -