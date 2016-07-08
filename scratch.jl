using DataFrames


x = convert(Array, readtable("names.csv"))

y = split(x[2], ' ')
