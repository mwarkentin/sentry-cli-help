# sentry-cli-help

[![crawl](https://github.com/mwarkentin/sentry-cli-help/actions/workflows/crawl.yaml/badge.svg)](https://github.com/mwarkentin/sentry-cli-help/actions/workflows/crawl.yaml)

A [help scraper](https://simonwillison.net/2022/Feb/2/help-scraping/) for [sentry-cli](https://github.com/getsentry/sentry-cli)

Scraping is automated with GitHub Actions.
Every day, the workflow installs the latest `sentry-cli` release, and crawls the output of `sentry-cli --help` and all subcommands.
The output is placed in [the `sentry-cli/` directory](./sentry-cli/).

## How is this useful?

You can use this repo to identify changes in `sentry-cli` releases.

GitHub also provides an undocumented RSS feed feature, which even lets you filter changes in certain paths.

Using this information you can count the number of unique CLI surfaces provided by `sentry-cli`:

```
❯ find sentry-cli -type f | wc -l
    44
```

Or find the longest CLI surface:

```
❯ for line in $(find sentry-cli -type f) ; do echo "${line%/*}" ; done | awk '{print length, $0}' | sort -rn | head -5 | sed -e "s+/+ +g"
43 sentry-cli releases files upload-sourcemaps
35 sentry-cli releases propose-version
33 sentry-cli react-native appcenter
33 sentry-cli difutil bundle-sources
32 sentry-cli releases files upload
```

---

All text content is owned by Sentry, licensed under the [BSD 3-Clause "New" or "Revised" License](https://opensource.org/licenses/BSD-3-Clause).

Code in the repo is based on the work by Jason Hall in [imjasonh/gcloud-help](https://github.com/imjasonh/gcloud-help), licensed under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0).
