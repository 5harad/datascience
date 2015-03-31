# install required packages
install.packages(c("dplyr", "nycflights13"))

# load packages to workspace
library("dplyr")
library("nycflights13")


# row selection with filter() and slice()
# default AND operation
filter(flights, month == 1, day == 1)

# explicitly use an OR operation
filter(flights, month == 1 | month == 2)

# select first 10 rows
slice(flights, 1:10)

# select last 10 rows
slice(flights, (n()-9):n())


# arranging rows with arrange()
arrange(flights, year, month, day)
arrange(flights, year, desc(month), day)
arrange(flights, year, month, desc(day))
arrange(flights, year, desc(month), desc(day))


# selecting subset of columns
select(flights, carrier, tailnum)
select(flights, -c(year, month, day))

select(flights, starts_with("dep"))
select(flights, matches("_d"))
select(flights, contains("_"))

select(flights, tail_num = tailnum)
rename(flights, tail_num = tailnum)


# create new columns with mutate
mutate(flights, gain = arr_delay - dep_delay, speed = distance / air_time * 60)
mutate(flights, gain = arr_delay - dep_delay,
                gain_per_hour = gain / (air_time / 60))
transmute(flights, gain = arr_delay - dep_delay,
                   gain_per_hour = gain / (air_time / 60))


# collapse data into a single row
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))


# group_by
flights_by_day <- group_by(flights, day)

summarise(flights_by_day,
          count = n(),
          dist = mean(distance, na.rm = TRUE),
          delay = mean(arr_delay, na.rm = TRUE))
