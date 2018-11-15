function binomial_rv(n,p)
    r=0
    for i=1:n
        u = rand()
        if u<p
            r+=1
        end
    end
    return r
end
