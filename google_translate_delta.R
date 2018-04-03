library(googleLanguageR)
gl_auth("RClass-Translator.json")
library(tuneR)

aws.signature::use_credentials(profile = "polly")
# language = "ro-RO"
language = "es-ES"
gl_language = strsplit(language, "-")[[1]][1]

text = readLines("datacamp_english.txt")
text = text[ text != ""]

trans_esp = gl_translate(text, target = "es")
writeLines(trans_esp$translatedText, con = "datacamp_gl_translated.txt")
