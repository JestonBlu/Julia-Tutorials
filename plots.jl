using Plots

plot(rand(5))

# GR backend, writes plots to window
gr()
plot(rand(5))

# Using Plotly backend, writes plots to browser
plotly()
plot(rand(5))

# Unicode plots, writes plots to console
unicodeplots()
plot(rand(5))
