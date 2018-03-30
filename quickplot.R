library(dplyr)
library(ggplot2)
df = data_frame(x = rnorm(100)) %>%
  mutate(y = 0.2* x + x^2 * 0.5 + rnorm(100))
g = df %>%
  ggplot(aes(x, y)) +
  geom_point() +
  geom_smooth(se = FALSE)
png("quickplot.png", height = 7, width = 14, units = "in", res = 300)
g
dev.off()
