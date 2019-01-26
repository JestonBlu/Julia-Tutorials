using Plots

plot(rand(5))

# GR backend, writes plots to window
gr()
plot(rand(5))

# Using Plotly backend, writes plots to browser
plotly()
plot(rand(5))

# Unicode plots, writes plots to console
# Pretty much limited to lines and scatters
unicodeplots()
plot(rand(5))

# using GR, no dependencies
gr()

# assumes x and y
plot(rand(5), rand(5))

# assumes x=1:5, 2 y series
plot([rand(10), rand(10)])
# equivalent
plot(rand(10, 2))

scatter(rand(10,2))
scatter(rand(10,2), rand(10,2))

using Distributions, StatPlots
d = Normal()

# Plots using StatPlots Recipe
plot(d)

x = rand(d, 1000)
y = rand(d, 1000)

scatter(x, y, title = "Random Normal Samples")
histogram(x)

# Plotting with dataframes
using RDatasets

dta = dataset("datasets", "iris")

@df dta scatter(:SepalLength, :SepalWidth, group = :Species)
