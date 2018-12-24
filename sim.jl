# Simulation of basic genetic mutation
# ------------------------------------------------------------------------------
# For each value in a matrix, randomly select all possible adjacent values and
# randomly assign an adjacent value to the current value, stop when one wins


# Starting matrix size
size = (3, 3)

# Generate random matrix
matrix = rand(1:8, size[1], size[2])

# Create empy array and append each matrix position to loop through
matrixPosition = Array([])

for i in 1:size[1], j in 1:size[2]
    push!(matrixPosition, (i,j))
end

# Function for getting a list of all adjacent positions and values
function getAdjacentPositions(x::Tuple, size::Tuple)
    # Position limits
    bottomRight = deepcopy(size)
    bottomLeft  = (size[1], size[2] - size[2] + 1)
    topRight    = (size[1] - size[1] + 1, size[2])
    topLeft     = (size[1] - size[1] + 1, size[2] - size[2] + 1)

    # Positions adjacent to current
    oneUp    = (x[1], x[2] - 1)
    oneDown  = (x[1], x[2] + 1)
    oneLeft  = (x[1] - 1, x[2])
    oneRight = (x[1] + 1, x[2])
    positions = [oneUp, oneDown, oneLeft, oneRight]

    # Determine which positions fall within the bounds of the matrix
    outOfBounds = Array([])

    append!(outOfBounds, map(x -> x[1] .>= topLeft[1]     && x[2] .>= topLeft[2],     positions))
    append!(outOfBounds, map(x -> x[1] .>= topRight[1]    && x[2] .<= topRight[2],    positions))
    append!(outOfBounds, map(x -> x[1] .<= bottomLeft[1]  && x[2] .>= bottomLeft[2],  positions))
    append!(outOfBounds, map(x -> x[1] .<= bottomRight[1] && x[2] .<= bottomRight[2], positions))

    outOfBounds = reshape(outOfBounds, 4, 4)
    positions = hcat(positions, outOfBounds)

    # Positions to keep
    positions = positions[positions[:, 2] .== true, :]
    positions = positions[positions[:, 3] .== true, :]
    positions = positions[positions[:, 4] .== true, :]
    positions = positions[positions[:, 5] .== true, :]

    positions = positions[:, 1]

    adjacentLength = length(positions)
    adjacentValues = Array([])

    # Loop through the adjacent positions to identify adjacent values
    for i in 1:adjacentLength
        append!(adjacentValues, matrix[positions[i][1], positions[i][2]])
    end

    # randomly select adjacent value which will become the current value
    return rand(adjacentValues)
end

matrix = map(x -> getAdjacentPositions(matrixPosition[x], size), 1:length(matrix))
matrix = reshape(matrix, 3, 3)
