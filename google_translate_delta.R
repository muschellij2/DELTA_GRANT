library(googleLanguageR)
library(dplyr)
gl_auth("RClass-Translator.json")
library(here)

langs = googleLanguageR::gl_translate_languages()

root_dir = here::here()
transdir = file.path(root_dir, "translations")
readr::write_rds(langs, file.path(transdir, "languages.rds"))

text = readLines(file.path(transdir, "datacamp_english.txt"))
# text = text[ text != ""]
# all_langs = gl_translate_languages( )
run_langs = c("fr", "de", "it", "ja", "ko", "pl", "ro", "es")
df = data_frame(target = run_langs) %>%
  mutate(app = paste0("_", target))

idf = 1

for (idf in seq(nrow(df))) {
  outfile = paste0("datacamp_gl_translated", df$app[idf], ".txt")
  outfile = file.path(transdir, outfile)
  if (!file.exists(outfile)) {
    trans_esp = gl_translate(text, target = df$target[idf])
    writeLines(trans_esp$translatedText,
               con = outfile)
  }
}

