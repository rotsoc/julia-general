using LinearAlgebra
v = rand(4)
Diagonal(v) + v*v'

struct Custom2{T} <: AbstractMatrix{T}
     v::Vector{T}
end

Base.size(c::Custom2)         =   length(c.v), length(c.v)
Base.getindex(c::Custom2,i,j) =   c.v[i]*(i==j)  + c.v[i]*c.v[j]

C = Custom2([1.0,2,3,4])

dump(C)

M = Matrix(C)
dump(M)

C * [1,2,3,4] # Matrix times vector automatically works though may not be efficient for large n.

# Matrix times vector with O(n) operations (3n multiplications , 2n additions)
Base.:*(c::Custom2, x::Vector) = (c.v) .* x + c.v * (c.v'x)

C * [1,2,3,4] # same answer, now efficient

using Pkg
haskey(Pkg.installed(),"Arpack") || Pkg.add("Arpack")
using Arpack
svds(C,nsv=1)[1].S

C = Custom2([1.0,2.0,3.0])
M = Matrix(C)

S = Symmetric(M)
eigmax(M)

# svds(C,3)

f(c::Custom2)  = λ ->  1 + sum(c.v[i]^2 / (c.v[i] - λ)   for i=1:length(c.v))
f′(c::Custom2) = λ ->      sum(c.v[i]^2 / (c.v[i] - λ)^2 for i=1:length(c.v))

function LinearAlgebra.eigmax(c::Custom2; tol = eps(2.0), debug = false)
    x0 = maximum(c.v) + maximum(c.v)^2
    δ = f(c)(x0)/f′(c)(x0)
    while abs(δ) > x0 * tol
        x0 -= δ
        δ = f(c)(x0)/f′(c)(x0) # Newton's Method
        debug && println("x = $x0, δ = $δ") # Debugging
    end
    x0
end

v = randn(3000)
C = Custom2(v)
M = Matrix(C)
S = Symmetric(M);

@time eigmax(S) # Special Symmetric eigenmax

@time maximum(eigvals(M)) # Vanilla LAPACK solver just a bit slower

@time eigmax(C) # run twice, no comparison
