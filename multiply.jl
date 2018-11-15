function multiply(x,y)
    if y==0
        return 0
    end
    z = multiply(x,floor(y/2))
    if y%2==0
        return 2*z
    else
        return x+2*z
    end
end
