using RDatasets
using DataFrames
using Statistics

iris = dataset("datasets", "iris")

describe(iris)

# first 3 Rows
iris[1:3, :]

# first 3 columns
iris[:, 1:3]

# operations across columns
colwise(sum, iris[:, 1:3])

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

# summarizing
describe(iris)
mean(iris[1])

# join
x = DataFrame(Species = "setosa")
join(iris, x, on = :Species)
join(iris, x, on = :Species, kind = :left)

# copy the dataframe
iris2 = iris

# rename columns
names(iris)
names(iris2)
rename!(iris2, :Species => :Species2)
# deepcopy prevents name changes from extending to source object
names(iris)
