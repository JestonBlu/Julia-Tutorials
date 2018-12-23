# Multidimensional Arrays are built in

# Int defaults to 64
zeros(Int8, (2,3))
zeros(Int, 2, 3)

vcat([1, 2], [3, 4])
hcat([1, 2], [3, 4])

[1 2 ; 3 4]

# Reshape
reshape(collect(1:9), (3,3))
reshape(collect(1:8), (2,2,2))

x = reshape(collect(1:9), (3,3))
# First row
x[1, :]
# Last row
x[end, :]
# First column
x[:, 1]
