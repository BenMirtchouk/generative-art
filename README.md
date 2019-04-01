# generative-art

This is a repo to house some of the generative art that I have worked on, which for the time being is all in [Processing](https://processing.org)

## Frames to GIF

Many of the animated works have an option to record the output in the form of the statement
```java
boolean record = false;
```

Setting this to true will save the frames of animation to `frames/frame_###.jpg`. [ffmpeg](https://ffmpeg.org) is a useful tool to consolidate these frames into a gif via:

```bash
ffmpeg -i frames/frame_%03d.jpg -vf palettegen palette.png
ffmpeg -v warning -i frames/frame_%03d.jpg -i palette.png  -lavfi "paletteuse,setpts=PTS" -y out.gif
```

Note that for larger projects, you may need frame_%04d.jpg (i.e. 4 digit frame numbers).