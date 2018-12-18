using RDatasets
using DataFrames
using Statistics
using Missings
using CategoricalArrays

# iris dataframe from R
iris = dataset("datasets", "iris")

# summary in R
describe(iris)
describe(iris, stats=[:eltype, :nmissing, :first, :last])

# first 3 Rows
iris[1:3, :]

# first 3 columns
iris[1:3]

# specific column
iris[:Species]
iris[[:Species, :SepalLength]]

# operations across columns
colwise(sum, iris[1:3])

# build a dataframe from scratch, quotations vs ticks matters
DataFrame(A = 1:4, B = ["a", "b", "c", "d"])

# dataframe dimensions
size(iris)
# rows only
size(iris, 1)
size(iris)[1]
# columns only
size(iris, 2)
size(iris)[2]

# manually adding a new row
push!(iris, [0, 0, 0, 0, "other"])
iris = vcat(iris, DataFrame(SepalLength = 0, SepalWidth = 0,
                            PetalLength = 0, PetalWidth = 0,
                            Species = "other"))

typeof(iris)

# end and beginning of dataset
last(iris, 5)
first(iris)

# summarizing
describe(iris)
mean(iris[1])
mean(iris.PetalLength)

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

iris = dataset("datasets", "iris")


# subsetting, . is for broadcasting
iris[iris[:SepalLength] .> 2.0, :]
iris[iris.SepalLength .> 2.0, :]

iris[(iris[:SepalLength] .> 2.0) .& (iris[:SepalWidth] .> 2.0), :]
iris[(iris.SepalLength .> 2.0) .& (iris.SepalWidth .> 2.0), :]


# simple loop using eachcol()
# 2 represents the second part of the tuple that is returned by col
for col in eachcol(iris[1:5, 1:4], true)
    println(col)
end

for col in eachcol(iris[1:4], true)
    println(mean(col[2]))
end

println("Sepal\t\tMean\tStdDev\t\tPetal\t\tMean\tStdDev\t\tCorr\t")

map((xcol,ycol) -> println(
    xcol,                               "\t",
    round(mean(iris[xcol]), digits=3),  "\t",
    round(std(iris[xcol]), digits=3),   "\t\t",
    ycol,                               "\t",
    round(mean(iris[ycol]),digits=3),   "\t",
    round(std(iris[ycol]), digits=3),   "\t\t",
    round(cor(iris[xcol],iris[ycol]), digits=3)),

    [:SepalWidth, :SepalLength],[:PetalWidth, :PetalLength]);

## Split and Apply Functions
# by function, similar to ddply function in R
# [DF, Columns, aggregation functions]
by(iris, :Species, N = :Species2 => length, mean = :PetalLength => mean)

by(iris, :Species, [:PetalLength, :SepalLength] =>
    x -> (a = mean(x.PetalLength) / mean(x.SepalLength),
          b = sum(x.PetalLength)))

# not the best performance
by(iris, :Species) do df
    (m = mean(df.PetalLength), s² = var(df.PetalLength))
end

# Aggregate function applies the function to all columns not part of the group by
# [DF, Columns, aggregation function]
aggregate(iris, :Species, length)
aggregate(iris, :Species, [sum, mean])

# For subsetting
for subdf in groupby(iris, :Species)
    println(size(subdf, 1))
end

## Reshaping
x = first(iris, 2)

# More control, pick the measure colums first, 3rd arguement is optionl group by
stack(x, 1:2)
stack(x, 1:4)
stack(x, [:SepalLength, :SepalWidth, :PetalLength, :PetalWidth])

# Pick the group by columns, melts all others
x[:id] = 1:size(x, 1)
x = melt(x, [:Species, :id])

# Needs an id column
unstack(x, :id, :variable, :value)

# Combine melt and aggregation
d = melt(iris, :Species)
x = by(d, [:variable, :Species], df -> DataFrame(mean = mean(df.value)))

## Sorting
sort!(iris)
sort!(iris, [:SepalWidth, :Species])
sort!(iris, (:Species, order(:SepalLength, rev = true)))
sort!(iris, (:Species, :SepalLength, :SepalWidth), rev = (true, false, false))
sort!(iris, (order(:Species, rev = true), :SepalLength, :SepalWidth))

## Categorical data
cv = ["Group A", "Group A", "Group A", "Group B", "Group B", "Group B"]
cv = CategoricalArray(["Group A", missing, "Group A", "Group B", "Group B", missing])

levels(cv)
levels(iris[:Species])

categorical!(iris, :Species)
