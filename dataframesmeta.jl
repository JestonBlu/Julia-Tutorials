using DataFrames
using DataFramesMeta
using RDatasets

iris = dataset("datasets", "iris")

@linq iris |>
    where(:PetalLength .> 4) |>
    by(:Species, min = minimum(:PetalWidth), max = maximum(:PetalWidth)) |>
    select(:Species, range = :max - :min)


@linq iris |>
    where(:PetalLength .> 4) |>
    by(:Species, min = minimum(:PetalWidth), max = maximum(:PetalWidth)) |>
    transform(value0 = :max .- minimum(:min))
