#########################################
## Test
using Gadfly
using Distributions

p = Normal()

x = collect(-3:.05:3)
y = pdf(p, x)

plot(x = x, y = y, Geom.line)

#########################################
