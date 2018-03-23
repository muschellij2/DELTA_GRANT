if (!require(cranlogs)) {
  library(devtools)
  install_github("metacran/cranlogs")
  library(cranlogs)
}
library(dplyr)
library(ggplot2)
library(ggrepel)
library(lubridate)

first_date = "2014-01-10"
today = Sys.Date()
long_today = format(Sys.time(), "%B %d, %Y")
# packs = c("brainR", "diffr", "freesurfer", "fslr",
#           "kirby21.base", "kirby21.fmri",
#           "kirby21.t1", "matlabr", "neurobase", "neurohcp",
#           "oasis", "papayar", "rscopus", "spm12r", "WhiteStripe")
# from crandb
packs = c("brainR", "cifti", "fedreporter", "freesurfer", "fslr",
          "gifti", "kirby21.base", "kirby21.fmri",
          "kirby21.t1", "matlabr", "neurobase", "neurohcp", "neurovault",
          "papayar", "spm12r", "stapler", "WhiteStripe")

packs = sort(unique(packs))

packs = unique(packs)
dl = cran_downloads( from = first_date, to = today,
                     packages = packs)
cs = dl %>%
  group_by(package) %>%
  mutate(count = cumsum(count)) %>%
  filter(count > 0)

maxes = dl %>%
  group_by(package) %>%
  summarize(count = sum(count),
            date = max(date) + as.period(10, unit = "week"))


visible_words = theme(text = element_text(size = 20))

g =  cs %>%
  ggplot(aes(x = date,
             y = count,
             colour = package)) +
  geom_line() +
  geom_text(data = maxes, aes(x = date,
                                    y = count,
                                    group = package,
                                    label = package),
            size = 5) +
  guides(colour = FALSE) + theme_bw() +
  xlab("Cumulative Number of Downloads") +
  ylab("Date") +
  visible_words
png("imaging_package_downloads.png",res = 600,
    height = 10, width = 14, units = "in")
print(g)
dev.off()

