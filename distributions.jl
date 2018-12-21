using Compat, Random, Distributions

# set seed
Random.seed!(123)

# normal distribution
d = Normal()
x = rand(d, 100)

# quantiles of the distribution
quantile.(d, [.01, .99])

# Normal with different mean and sd
d = Normal(5, 1)
quantile.(d, [.01, .99])

# distribution parameters
fieldnames(Normal)
params(d)

# fit data
fit(Normal, x)

## Distributions and params
# Statistics
d = Normal()
location(d)
scale(d)

d = Poisson()
rate(d)

d = Weibull()
shape(d)
scale(d)

d = Binomial(3)
ntrials(d)
succprob(d)
failprob(d)

d = Uniform()
location(d)
scale(d)

d = Chisq(10)
dof(d)

## Summary Statistics
mean(x)
std(x)
var(x)
median(x)

## Evaluate Moment Generating Function
d = Normal()
mgf(d, 1)
mgf(d, 1.1)
mgf(d, 1.5)

## Probability Evaluation
d = Binomial()
maximum(d)
insupport(d, 2)

d = Normal()
pdf(d, 1.96)
cdf(d, 1.96)
loglikelihood(d, [0, .1, -.1])

## Truncated Distribution
d = Truncated(d, -3, 1.5)
insupport(d, 2)
maximum(d)
cdf(d, 1.49)

## Mixture Distributions
d = MixtureModel(Normal[Normal(-2.0, 1.2), Normal(0.0, 1.0), Normal(3.0, 2.5)], [0.2, 0.5, 0.3])
rand(d, 3)
mean(d)
cdf(d, 1.96)

# components and prior probabilities
components(d)
probs(d)
