using TimeSeries
using Dates

dates = Date(2018, 1, 1):Day(1):Date(2018, 12, 31)
ta = TimeArray(dates, rand(length(dates)))

# TimeArray field types
timestamp(ta)
colnames(ta)
values(ta)
meta(ta)

# Subsets
ta[1]
ta[1:3]
ta[[1:3 ;8]]
ta[end]

# Mondays
when(ta, dayofweek, 1)
when(ta, dayname, "Monday")

# First day or each month
when(ta, dayofmonth, 1)

# All of January
when(ta, monthname, "January")
when(ta, month, 1)

# From/to
from(ta, Date(2018, 06, 01))
to(ta, Date(2018, 06, 01))

# Returns time or int index based on condition
findwhen(ta .> .5)
findall(ta .> .5)

# update add new obs only
update(ta, Date(2019, 01, 01), 0.0)

# rename
ta = rename(ta, :dta)


# transformations
lag(ta[1:3])
lag(ta[1:3], padding = true)
diff(ta[1:3], padding = true)
percentchange(ta, :log, padding = true)

using Statistics
moving(mean, ta, 10)

upto(sum, ta[1:10])
basecall(ta[1:10], cumsum)

# Monthly average
collapse(ta, month, first, mean)

# Adjust dates and values
map((timestamp, values) -> (timestamp + Year(1), values + 1), ta)

# Plotting
using Plots

plot(ta)
