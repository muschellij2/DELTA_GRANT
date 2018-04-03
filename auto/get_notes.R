library(xml2)
library(magrittr)
library(here)
library(utf8)

fname = file.path(here::here(), "auto", "DELTA.pptx")

xml_notes = function(xml_fname) {
  require(xml2)
  require(magrittr)
  xdoc = read_xml(xml_fname)
  txt = xdoc %>% xml_find_all("//a:t") %>% xml_text()
  txt = paste(txt, collapse = " ")
}
get_gs_pptx_notes = function(fname) {
  require(utf8)
  tdir = tempfile()
  dir.create(tdir)
  res = unzip(fname, exdir = tdir)
  note_dir = file.path(tdir, "ppt", "notesSlides")
  notes = list.files(path = note_dir, pattern = "[.]xml$",
                     full.names = TRUE)
  if (length(notes) > 0) {
    res = sapply(notes, xml_notes)
    names(res) = basename(notes)
    # res = utf8::utf8_normalize(res, map_quote = TRUE)
    return(res)
  } else {
    return(NULL)
  }
}


script = get_gs_pptx_notes(fname)

writeLines(script, con = "script.txt")

