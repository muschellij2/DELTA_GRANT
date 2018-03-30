library(ari)
library(aws.polly)

aws.signature::use_credentials(profile = "polly")

files = list.files(pattern = ".png$",
                   full.names = TRUE)
para = readLines("script.txt")
para = para[ !para %in% ""]
ari_spin(paragraphs = para,
         images = files, output = "joey.mp4",
         voice = "Joey")
ari_spin(paragraphs = para,
         images = files, output = "kim.mp4",
         voice = "Kimberly")

