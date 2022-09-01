#!/bin/bash

for img in /root/*.AppImage
do
  cp ${img} /export
done
