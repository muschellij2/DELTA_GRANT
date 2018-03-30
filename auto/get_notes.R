library(xml2)
library(magrittr)
library(officer)
library(here)

x = read_pptx(file.path(here::here(), "auto", "DELTA2.pptx"))
notes_dir = file.path(x$package_dir, "ppt", "notesSlides")
files = list.files(pattern = ".xml$",
                   path = notes_dir, full.names = TRUE)
get_notes = function(fname) {
  xdoc = read_xml(fname)
  txt = xdoc %>% xml_find_all("//a:t") %>% xml_text()
  txt = paste(txt, collapse = " ")
  cat(txt)
  return(txt)
}
script = sapply(files, get_notes)

writeLines(script, con = "script.txt")

