# Largest prime factor

function primefactors(n::Int)
    f = factors(n)
    pf = []
    for i in f
        if length(factors(i))==2
            push!(pf,i)
        end
    end
    return pf
end

function factors(n::Int)
    ff = []
    for i=1:n
        if n%i == 0
            push!(ff,i)
        end
    end
    return ff
end

function largestprime(n::Int)
    return maximum(primefactors(n))
end
