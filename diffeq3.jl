# uₓₓ = sin(2πx)

using LinearAlgebra
using Plots

Δx = 0.1
x = Δx:Δx:1-Δx # Solve only for the interior! Boundary points zero

N = length(x)

B = sin.(2π*x)

A = zeros(N,N)

for i in 1:N, j in 1:N
    abs(i-j)<=1 && (A[i,j]+=1)
    i==j && (A[i,j]-=3)
end

A = A/(Δx^2)

U = A\B

plot([0;x;1],[0;U;0],label="U")
