using RDatasets
using DataFrames
using Statistics

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
first(iris, 5)

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

# summarising
by(iris, :Species2, :PetalLength => mean)
by(iris, :Species2, N = :Species2 => length, mean = :PetalLength => mean)
by(iris, :Species2, [:PetalLength, :SepalLength] =>
              x -> (a=mean(x.PetalLength)/mean(x.SepalLength), b=sum(x.PetalLength)))
