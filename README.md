# Youtube mp3 downloader

[![Build Status](https://travis-ci.org/kishaningithub/youtube-mp3-downloader.svg?branch=master)](https://travis-ci.org/kishaningithub/youtube-mp3-downloader)

Downloads list of youtube urls into mp3

## Usage

```bash
cat youtube_urls.txt | docker run --rm -i -v `pwd`:/output kishanb/youtube-mp3-downloader:1.0.0
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Older releases

The older versions of this can be found in project's [Docker hub repo page](https://hub.docker.com/r/kishanb/youtube-mp3-downloader/)