using RDatasets
using DataFrames
using GLM

dta = dataset("datasets", "iris")

mdl = lm(@formula(SepalLength ~ PetalLength + Species), dta)

# Standard Errors and predictions
stderror(mdl)
predict(mdl)
confint(mdl)

mdl = glm(@formula(SepalLength ~ PetalLength + Species), dta, Normal())
