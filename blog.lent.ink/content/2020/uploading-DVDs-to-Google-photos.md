---
title: "Uploading DVDs to Google Photos for unlimited free backup"
date: "2020-10-13"
draft: true
---



```
du -h VIDEO_TS/*.VOB|sort -h
156K    VIDEO_TS/VIDEO_TS.VOB
156K    VIDEO_TS/VTS_02_0.VOB
156K    VIDEO_TS/VTS_03_0.VOB
129M    VIDEO_TS/VTS_01_0.VOB
137M    VIDEO_TS/VTS_03_1.VOB
184M    VIDEO_TS/VTS_02_1.VOB
226M    VIDEO_TS/VTS_01_2.VOB
1.0G    VIDEO_TS/VTS_01_1.VOB
```



```
svlentink@penguin:/mnt/chromeos/removable/maxtor 500 GB/to-save-20200914/bin/to_google_photos/already_uploade/ecuadorCD$ file *
ecuadorcd.mpeg:   MPEG sequence, v1, system multiplex
ecuador_dvd.mpeg: MPEG sequence, v1, system multiplex
outfile.webm:     WebM
VIDEO_TS:         directory
svlentink@penguin:/mnt/chromeos/removable/maxtor 500 GB/to-save-20200914/bin/to_google_photos/already_uploade/ecuadorCD$ file VIDEO_TS/*.VOB
VIDEO_TS/VIDEO_TS.VOB: MPEG sequence, v2, program multiplex
VIDEO_TS/VTS_01_0.VOB: MPEG sequence, v2, program multiplex
VIDEO_TS/VTS_01_1.VOB: MPEG sequence, v2, program multiplex
VIDEO_TS/VTS_01_2.VOB: MPEG sequence, v2, program multiplex
VIDEO_TS/VTS_02_0.VOB: MPEG sequence, v2, program multiplex
VIDEO_TS/VTS_02_1.VOB: MPEG sequence, v2, program multiplex
VIDEO_TS/VTS_03_0.VOB: MPEG sequence, v2, program multiplex
VIDEO_TS/VTS_03_1.VOB: MPEG sequence, v2, program multiplex
```

```

```

And here's a oneliner for ripping DVDs
```shell
for f in `ls VIDEO_TS/*.VOB`; do \
  if du -h $f|awk '{print $1}'|grep -q K; then \
    echo "$f smaller than 1MB, skipping it"; \
    continue; \
  fi; \
  cat $f \
    | ffmpeg -i - -c:v copy -c:a copy $f.mpeg 2>&1 \
    | grep -v 'buffer underflow' \
    | grep -v 'Last message repeated'; \
done
```
