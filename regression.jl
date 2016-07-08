using Gadfly

## Response Variable
Y = [.25, .13, .65, .4, 1.1]

## Design Matrix
X = reshape([ones(Int, 5); collect(1:1:5)], 5, 2)

## Projection Matrix
β = inv(X' * X) * X'

## Solve Betas
β * Y

## Calculate Predicted values
y = X * (β * Y)

## Plot regression
plot(layer(x = X[:,2], y = Y, Geom.point),
     layer(x = X[:,2], y = y, Geom.line))

## Hat Matrix
H = X * β

## Leverage Points
diag(H)
