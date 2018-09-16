using RDatasets
using DataFrames

iris = dataset("datasets", "iris")

describe(iris)

# first 3 Rows
iris[1:3, :]

# first 3 columns
iris[:, 1:3]

# operations across columns
colwise(sum, iris[:,1:3])

# build a dataframe from scratch, quotations vs ticks matters
DataFrame(A = 1:4, B = ["a", "b", "c", "d"])

# Dataframe dimensions
size(iris)
size(iris)[1]
size(iris)[2]

# manually adding a new row
push!(iris, [0, 0, 0, 0, "other"])

# end and beginning of dataset
tail(iris)
head(iris)
