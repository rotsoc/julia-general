function my_round(x)
    y = x + 0.5
    r = string(y)[1]
    r = parse(Int,r)
    return r
end
