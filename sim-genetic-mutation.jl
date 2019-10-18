# Simulation of basic genetic mutation
# ------------------------------------------------------------------------------
# For each value in a matrix, randomly select all possible adjacent values and
# randomly assign an adjacent value to the current value, stop when one wins

using DataFrames
using VegaLite

# Starting matrix size
matrixSize = (3, 3)

# Generate random matrix
matrix = rand(1:8, matrixSize[1], matrixSize[2])

# Create empty array and append each matrix position to loop through
matrixPosition = Array([])

for i in 1:matrixSize[1], j in 1:matrixSize[2]
    push!(matrixPosition, (i,j))
end

# Function for getting a list of all adjacent positions and values
function getAdjacentPositions(matrixPosition::Tuple, matrixSize::Tuple)

    x = matrixPosition

    # Position limits
    bottomRight = matrixSize
    bottomLeft  = (matrixSize[1],  matrixSize[2] - matrixSize[2] + 1)
    topRight    = (matrixSize[1] - matrixSize[1] + 1, matrixSize[2])
    topLeft     = (matrixSize[1] - matrixSize[1] + 1, matrixSize[2] - matrixSize[2] + 1)

    # Positions adjacent to current
    oneUp     = (x[1], x[2] - 1)
    oneDown   = (x[1], x[2] + 1)
    oneLeft   = (x[1] - 1, x[2])
    oneRight  = (x[1] + 1, x[2])
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
    adjacentValues = Array([matrix[x[1], x[2]]])

    # Loop through the adjacent positions to identify adjacent values
    for i in 1:adjacentLength
        append!(adjacentValues, matrix[positions[i][1], positions[i][2]])
    end

    # randomly select adjacent value which will become the current value
    return rand(adjacentValues)
end

matrix = reshape(
    map(x -> getAdjacentPositions(matrixPosition[x], matrixSize), 1:length(matrix)),
    matrixSize[1], matrixSize[2]
    )

# Plot the heatmap
function heatmapPlot(matrix)

    # Convert matrix into a data frame for plotting
    function convertDataFrame(matrix)
        x = []; y = []; z = []
        for i in 1:matrixSize[1], j in 1:matrixSize[2]
            push!(x, string("x", i))
            push!(y, string("y", j))
            push!(z, matrix[i, j])
        end

        plotDF = DataFrame(x = x, y = y, value = z)
        return plotDF
    end

    # Plot the starting matrix
    @vlplot(
        data = convertDataFrame(matrix),
        y = "x:o",
        x = "y:o",
        width = 400,
        height = 400,
        config={
            scale = {bandPaddingInner = 0, bandPaddingOuter = 0},
            text = {baseline=:middle}
        }) +
    @vlplot(:rect, color = :value, scheme = "accent") +
    @vlplot(
        :text,
        text = "value",
        color = {
            value = :white
        })
end

heatmapPlot(matrix)

# How many iterations till 1 factor is left?
i = 1
while length(unique(matrix)) > 1
    matrix = reshape(
        map(x -> getAdjacentPositions(matrixPosition[x], matrixSize), 1:length(matrix)),
        matrixSize[1], matrixSize[2])
        global matrix
        global i += 1
end
println(i)
