library(lubridate)
library(timevis) # daattali/timevis
library(readxl)
library(dplyr)
library(webshot)

df = read_excel("Timeline.xlsx")
df = df %>%
  mutate(
    start = sub("2019", "2020", start),
    end = sub("2019", "2020", end),
    start = sub("2018", "2019", start),
    end = sub("2018", "2019", end),)
df$start = mdy(df$start)
df$end = mdy(df$end)
df$id = seq(nrow(df))

df = df %>%
  select(id, content, start, end) %>%
  as.data.frame()
df$type = ifelse(is.na(df$end), "point", "range")
df$style = "font-size: 6pt;"
timevis(df, zoomFactor = 0.1, width = "1200px")

