FROM python:3.6.4-alpine

# ffmpeg installation (Special thanks to https://github.com/opencoconut/ffmpeg/blob/master/Dockerfile )
ENV FFMPEG_VERSION=3.4.1
RUN apk add --update build-base curl nasm tar bzip2 \
    zlib-dev openssl-dev yasm-dev lame-dev libogg-dev x264-dev libvpx-dev libvorbis-dev x265-dev freetype-dev libass-dev libwebp-dev rtmpdump-dev libtheora-dev opus-dev && \
    DIR=$(mktemp -d) && cd ${DIR} && \
    curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxvf - -C . && \
    cd ffmpeg-${FFMPEG_VERSION} && \
    ./configure \
    --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --enable-libx264 --enable-libx265 --enable-libvpx --enable-libtheora --enable-libvorbis --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc --enable-avresample --enable-libfreetype --enable-openssl --disable-debug && \
    make && \
    make install && \
    make distclean && \
    rm -rf ${DIR} && \
    apk del build-base curl tar bzip2 x264 openssl nasm && rm -rf /var/cache/apk/*

# youtube-dl installation (python is a run time dependency for this)
ENV YOUTUBE_DL_VERSION=2018.02.04
RUN apk add --update curl && \
    curl -sL https://github.com/rg3/youtube-dl/releases/download/${YOUTUBE_DL_VERSION}/youtube-dl -o /usr/local/bin/youtube-dl && \
    chmod a+rx /usr/local/bin/youtube-dl && \
    apk del curl && rm -rf /var/cache/apk/*

WORKDIR /output

ENTRYPOINT youtube-dl --extract-audio --audio-format mp3 --prefer-ffmpeg -f 140 -a -