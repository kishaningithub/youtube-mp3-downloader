FROM python:3.6.4-alpine

# ffmpeg installation (Special thanks to https://github.com/opencoconut/ffmpeg/blob/master/Dockerfile )
ENV FFMPEG_VERSION=3.4.1
RUN apk add --update build-base curl tar nasm \
    lame-dev && \
    DIR=$(mktemp -d) && cd ${DIR} && \
    curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxf - -C . && \
    cd ffmpeg-${FFMPEG_VERSION} && \
    ./configure \
    --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --disable-debug && \
    make && \
    make install && \
    make distclean && \
    rm -rf ${DIR} && \
    apk del build-base curl tar nasm && rm -rf /var/cache/apk/*

# youtube-dl installation (python is a run time dependency for this)
ENV YOUTUBE_DL_VERSION=2018.02.04
RUN apk add --update curl && \
    curl -sL https://github.com/rg3/youtube-dl/releases/download/${YOUTUBE_DL_VERSION}/youtube-dl -o /usr/local/bin/youtube-dl && \
    chmod a+rx /usr/local/bin/youtube-dl && \
    apk del curl && rm -rf /var/cache/apk/*

WORKDIR /output

ENTRYPOINT youtube-dl --extract-audio --audio-format mp3 --prefer-ffmpeg -f 140 -a -