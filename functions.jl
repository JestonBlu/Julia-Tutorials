# Equivalent function
function f(x, y)
    x + y
end

f(x, y) = x + y

∑(x,y) = x + y

# return operator, ignores last line
function g(x,y)
    return x * y
    x + y
end

g(2,3)

# Operator functions
+(1,2,3)
h = +;
h(1,2,3)

# Anonymous function
j -> j^2 + 2j - 1

# Functions with more than one return
function foo(a,b)
    a+b, a*b
end

foo(2,3)
x, y = foo(2,3)
x
y

# Optional arguement
function Date(y::Int64, m::Int64=1, d::Int64=1)
    err = validargs(Date, y, m, d)
    err === nothing || throw(err)
    return Date(UTD(totaldays(y, m, d)))
end

using Dates
Date(2017)

# Do Block
map([A, B, C]) do x
    if x < 0 && iseven(x)
        return 0
    elseif x == 0
        return 1
    else
        return x
    end
end
