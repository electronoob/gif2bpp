this file clobbers the following directories

./work/
./source/

if dirs do not exist it tries to create them

./done/
./work/
./source/

syntax

```bash
# ./gif2bpp.sh [frames per second] [delay in 100ths of seconds] [url of video to download]
```
conversions appear in the ./done/ directory and are time-stamped

tested on ubuntu, required these packages.
```bash
  sudo del-apt-repository universe
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt install ffmpeg
  sudo apt install imagemagick
```


license:
just be nice and say you used/modified the script from my repo, if you do then you're free to use it.
possible due to this info: http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html
