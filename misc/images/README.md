For adding blur and lock icon to the wallpaper:

```shell
magick wallpaper.png -blur 0x15 wallpaper-blur.png

magick wallpaper.png -blur 0x15 \
  lock.png -gravity northeast -geometry +180+180 -composite \
  wallpaper-lock.png
```

## Credits

- Lock icon - <https://fonts.google.com/icons>
- Wallpaper - <https://wallhaven.cc/w/gw2gyq>
