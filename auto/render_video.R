library(ari)
library(aws.polly)

# microsoft can do zh-CN
aws.signature::use_credentials(profile = "polly")

files = list.files(pattern = ".png$",
                   full.names = TRUE)
files = path.expand(files)


para = readLines("script.txt")
para = para[ !para %in% ""]
ari_spin(paragraphs = para,
         images = files, output = "joey.mp4",
         voice = "Joey",
         ffmpeg_opts = '-vf "scale=trunc(iw/2)*2:trunc(ih/2)*2"')


# ari_spin(paragraphs = para,
#          images = files, output = "kim.mp4",
#          voice = "Kimberly",
#          ffmpeg_opts = '-vf "scale=trunc(iw/2)*2:trunc(ih/2)*2"')

fname = "script_es.txt"

if (file.exists(fname)) {
  para = readLines(fname)
  para = para[ !para %in% ""]

  # ari_spin(paragraphs = para,
  #          images = files, output = "miguel.mp4",
  #          voice = "Miguel",
  #          ffmpeg_opts = '-vf "scale=trunc(iw/2)*2:trunc(ih/2)*2"')
  ari_spin(paragraphs = para,
           images = files, output = "penelope.mp4",
           voice = "Penelope",
           ffmpeg_opts = '-vf "scale=trunc(iw/2)*2:trunc(ih/2)*2"')
}
