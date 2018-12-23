for i in 1:10
    println(i)
end

i = 1
while i <= 5
    println(i)
    global i += 1
end

while true
    println(i)
    if i >= 5
        break
    end
    global i += 1
end

for j = 1:1000
    println(j)
    if j >= 5
        break
    end
end

for i = 1:10
    if i % 3 != 0
        continue
    end
    println(i)
end

for i = 1:2, j = 3:4
    println((i, j))
end
