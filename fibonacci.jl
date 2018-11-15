function fib1(n::Int)
    if n==0
        return 0
    elseif n==1
        return 1
    elseif n>1
        return fibonacci(n-1)+fibonacci(n-2)
    end
end

function approx_fib(n::Int)
    return 2^(0.694*n)
end

function fib2(n::Int)
    if n==0
        return 0
    end
    f = zeros(Int,n+1)
    f[1] = 0
    f[2] = 1
    for i=3:n+1
        f[i] = f[i-1] + f[i-2]
    end
    return f[n+1]
end

function fib3(n::Int)
    X = [0 1; 1 1]
    F = [0, 1]
    return ((X^(n-1))*F)[2]
end
