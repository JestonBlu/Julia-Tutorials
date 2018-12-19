using TimeSeries
using Dates
using MarketData

dates = Date(2018, 1, 1):Day(1):Date(2018, 12, 31)
ta = TimeArray(dates, rand(length(dates)))
