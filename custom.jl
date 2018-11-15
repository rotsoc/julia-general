using Roots
using ForwardDiff

struct Custom
    v

    function Custom(v)
        A = v*v'
        [A[i,i]+=v[i] for i=1:size(v,1)]
        return A
    end

end

function eigenmax(v)
    f(λ) = 1 + sum(v.^2 ./ (v.-λ))
    x0 = 1.0
    r = []
    zero = find_zeros(f, -100.0, 100.0)
    v_max = maximum(v)
    for z in zero
        if z > v_max
            push!(r,z)
        end
    end

    return r
end

function invCust(v)
    B = -(v*v') / (1 + v'*v)
    [B[i,i]+=1 for i=1:size(v,1)]
    return B
end
