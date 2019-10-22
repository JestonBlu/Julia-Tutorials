# Multidimensional Arrays are built in

# Int defaults to 64
zeros(Int8, (2, 3))
zeros(Int, 2, 3)
zeros(Int, 2, 3, 2)

vcat([1, 2], [3, 4])
hcat([1, 2], [3, 4])

[1 2 ; 3 4]

# Reshape
reshape(1:9, (3, 3))
reshape(1:9, 3, 3)
reshape(1:8, (2, 2, 2))

x = reshape(1:9, (3, 3))

# Rows
x[1, :]
x[1:2, :]

# Columns
x[:, 1]
x[:, 1:2]

# Last
x[:, end]
x[end, :]
