M = [2. 1; 1 1]
using LinearAlgebra
v = rand(2)
normalize!(v)    # only in Julia v0.5
#v /= norm(v)     # alternative: v = v / norm(v)
v = M * v
normalize!(v)
(M*v) ./ v
function power_method(M, v)
    for i in 1:100
        v = M*v        # repeatedly creates a new vector and destroys the old v
        v/=norm(v)
    end

    return v, norm(M*v) / norm(v)  # or  (M*v) ./ v
end
function power_method!(M, v)
    for i in 1:100
        v[:] = normalize(M*v)   # assign in-place to the elements of v
    end

    return v, norm(M*v) / norm(v)
end
power_method(M, rand(2))
power_method(3, 1)
D = Diagonal([1, 2, 3.])
D[2,2] = 10
D
v = [1, 2, 3.]
D*v
power_method(D, [1,1.,0.])
n = 100
S = SymTridiagonal(rand(n), rand(n-1))
vect, val = power_method(S, rand(n))
λ = eigvals(S)
val - maximum(abs.(λ))
M = BigFloat[2 1; 1 1.]
setprecision(BigFloat, 128)
v = [big(1.0), big(1.0)]
power_method(M, v)
λ = (3 + sqrt(big(5))) / 2
vect, val = power_method(M, v)
λ - val
