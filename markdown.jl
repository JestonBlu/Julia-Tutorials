using Base.Markdown

mark = md"""
  ## Julia Markdown Example

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
"""

write("markdown.html", git(mark))
