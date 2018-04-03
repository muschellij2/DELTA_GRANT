library(googleLanguageR)
library(dplyr)
gl_auth("../RClass-Translator.json")
library(here)

langs = googleLanguageR::gl_translate_languages()

text = readLines("script.txt")
run_langs = c("es")
df = data_frame(target = run_langs) %>%
  mutate(app = paste0("_", target))

idf = 1

for (idf in seq(nrow(df))) {
  outfile = paste0("script", df$app[idf], ".txt")
  if (!file.exists(outfile)) {
    trans_esp = gl_translate(text, target = df$target[idf])
    writeLines(trans_esp$translatedText,
               con = outfile)
  }
}

