# install required packages
install.packages(c("dplyr", "nycflights13"))

# load packages to workspace
library("dplyr")
library("nycflights13")

# row selection with filter()
# using AND operation
filter(flights, tailnum == "N14228" & arr_delay > 10)

# using OR operation
filter(flights, tailnum == "N14228" | tailnum == "N24211")

# mixing AND / OR operations (default behavior for multiple conditions is AND)
filter(flights, tailnum == "N14228" | tailnum == "N24211", arr_delay > 10)

# row selection with slice()
# select first 10 rows
slice(flights, 1:10)

# select last 10 rows
slice(flights, (n()-9):n())

# selecting subset of columns
select(flights, c(carrier, tailnum))
select(flights, -c(year, month, day))

# works without using combine (c())
select(flights, c(carrier, tailnum))
select(flights, -c(year, month, day))

# some helper functions
select(flights, starts_with("dep"))
select(flights, matches("_"))
select(flights, contains("delay"))

# using select to rename a column will result in data reduced to a single col.
select(flights, tail_num = tailnum)
# use the verb rename() instead
rename(flights, tail_num = tailnum)

# create new columns with mutate
mutate(flights, gain = arr_delay - dep_delay, speed = distance / air_time * 60)
mutate(flights, gain = arr_delay - dep_delay,
                gain_per_hour = gain / (air_time / 60))

# use transmute() if you just want to keep the new columns
transmute(flights, gain = arr_delay - dep_delay,
                   gain_per_hour = gain / (air_time / 60))

# arranging rows with arrange()
arrange(flights, year, month, day)
# use desc() to arrange in descending order
arrange(flights, year, desc(month), day)
arrange(flights, year, month, desc(day))
arrange(flights, year, desc(month), desc(day))

# collapse data into a single row
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

# group_by
flights_by_day <- group_by(flights, day)

# retrieve the first 2 rows of each day
slice(flights_by_day, 1:2)

# summarize (1) number of flights, (2) average distance, (3) average arrival
#     delay for each day (i.e., for flights grouped by day)
summarise(flights_by_day,
          count = n(),
          dist = mean(distance, na.rm = TRUE),
          delay = mean(arr_delay, na.rm = TRUE))

# chain multiple operations with the pipe operator (%>%)
flights %>%
  group_by(year, month, day) %>%
  summarise(arr = mean(arr_delay, na.rm = TRUE),
            dep = mean(dep_delay, na.rm = TRUE)) %>%
  filter(arr > 30 | dep > 30)
