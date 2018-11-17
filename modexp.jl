function modexp(x,y,N)
    # Input: two n-bit integers x and N, an integer exponent y
    # Output: xʸ mod N

    if y==0
        return 1
    end
    z = modexp(x,floor(y/2),N)
    if y%2 == 0
        return mod(z^2,N)
    else
        return mod(x*z^2,N)
    end
end
