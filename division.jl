function divide(x,y)
    # y>=1
    if x==0
        return (q,r)=(0,0)
    end
    (q,r) = divide(floor(x/2),y)
    q = 2*q
    r = 2*r
    if x%2==1
        r += 1
    end
    if r >= y
        r = r - y
        q = q + 1
    end
    return (q,r)
end
