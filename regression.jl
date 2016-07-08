using Gadfly

## Response Variable
y = [.25, .13, .65, .4, 1.2]

## Design Matrix
x = reshape([ones(Int, 5); collect(1:1:5)], 5, 2)

## Solve Betas
B = inv(x' * x) * x' * y

## Calculate Predicted values
x * B

## Plot regression
plot(layer(x = x[:,2], y = y, Geom.point),
     layer(x = x[:,2], y = x*B, Geom.line))
