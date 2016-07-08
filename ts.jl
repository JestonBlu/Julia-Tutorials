
## Packages
using Distributions
using Gadfly

## Parameters
n = 500
x = collect(1:1:n)
w = rand(Normal(), n)

## White Noise
wn = Array(Float64, n)

for i in 2:n
  wn[i] = w[i]
end

plot(x = x, y = wn, Geom.line)

## Random Walk
rw = Array(Float64, n)

for i in 2:n
  rw[i] = rw[i-1] + w[i]
end

plot(x = x, y = rw, Geom.line)


## Random Walk with drift
rw_d = Array(Float64, n)

for i in 2:n
  rw_d[i] = .1 + rw_d[i-1] + w[i]
end

plot(x = x, y = rw_d, Geom.line)

Markdown.parse_file()
