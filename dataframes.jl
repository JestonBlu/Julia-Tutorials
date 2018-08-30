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
