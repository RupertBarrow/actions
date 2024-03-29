# uptime

GitHub Action to check the status of endpoints. This action can be used to check a website is live after a deploy or on an ongoing basis via cron.

## Origin

This was forked from https://github.com/srt32/uptime
That repo is not being maintained : it has several issues reported about compatibility of versions, and pull requests have not been merged. That is why it has been forked here.

## Inputs

### url-to-hit

**Required** The url to hit

### expected-statuses

Comma separated list of statuses that are okay. Defaults to `"200"`

## Outputs

### status

The status we got.

## Example usage

```

on:
  schedule:
    - cron: '*/5 * * * *'

jobs:
  ping_site:
    runs-on: ubuntu-latest
    name: Ping the site
    steps:
    - name: Check the site
      id: hello
      uses: srt32/uptime@master
      with:
        url-to-hit: "https://example.com"
        expected-statuses: "200,301"
```
