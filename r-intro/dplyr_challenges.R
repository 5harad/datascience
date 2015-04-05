# install required packages
install.packages(c("dplyr", "nycflights13"))

# load packages to workspace
library("dplyr")
library("nycflights13")

# challenge answer
challenge_1 <- flights %>%
  group_by(carrier) %>%
  mutate(speed = distance / air_time * 60) %>%
  summarise(avg_speed= mean(speed, na.rm = TRUE)) %>%
  arrange(desc(avg_speed))
challenge_1

challenge_2 <- flights %>%
  group_by(month, carrier) %>%
  filter(month == 4 & hour > 10) %>%
  summarize(n())
challenge_2
