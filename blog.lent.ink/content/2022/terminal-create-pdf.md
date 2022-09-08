---
title: "Template"
date: "2021-01-01"
draft: true
tags: ["category01"]
---

  261  sudo apt install img2pdf
  262  img2pdf IMG_20220716_135506.jpg IMG_20220716_135519.jpg IMG_20220716_135528.jpg IMG_20220716_135542.jpg IMG_20220716_135550.jpg IMG_20220716_135601.jpg IMG_20220716_135615.jpg IMG_20220716_135629.jpg casa.pdf
  263  img2pdf IMG_20220716_135506.jpg IMG_20220716_135519.jpg IMG_20220716_135528.jpg IMG_20220716_135542.jpg IMG_20220716_135550.jpg IMG_20220716_135601.jpg IMG_20220716_135615.jpg IMG_20220716_135629.jpg
  264  img2pdf IMG_20220716_135506.jpg IMG_20220716_135519.jpg IMG_20220716_135528.jpg IMG_20220716_135542.jpg IMG_20220716_135550.jpg IMG_20220716_135601.jpg IMG_20220716_135615.jpg IMG_20220716_135629.jpg > casa.pdf
  265  which dig

  284  for i in IMG*;do convert -resize 50% $i $i.s;done
  285  ls -al
  286  img2pdf IMG_*.jpg.s > compra-vende-small.pdf

and if it need `convert` to remove alpha channel of PNGs,
do
```
apt install -y imagemagick
```
