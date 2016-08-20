#!/bin/bash
#
# shoutout m3u playlist
#

curl -s -X POST -H 'Content-Length: 0' http://www.shoutcast.com/Home/Top |
  jq '.[].ID' |
    parallel --eta -k curl -s 'http://yp.shoutcast.com/sbin/tunein-station.m3u?id={}' |
      sed '1!s@#EXTM3U@@' |
        cat -s |
          gzip > shoutcast_$(date +%F).m3u.gz
