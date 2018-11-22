#######################################################
### Solve the PDE
#######################################################

using OrdinaryDiffEq, RecursiveArrayTools, LinearAlgebra

# Define the constants for the PDE
const α₂ = 1.0
const α₃ = 1.0
const β₁ = 1.0
const β₂ = 1.0
const β₃ = 1.0
const r₁ = 1.0
const r₂ = 1.0
 D = 100.0
const γ₁ = 0.1
const γ₂ = 0.1
const γ₃ = 0.1
const N = 100
#const X = reshape([i for i in 1:100 for j in 1:100],N,N)
#const Y = reshape([j for i in 1:100 for j in 1:100],N,N)
#const α₁ = 1.0.*(X.>=80)
const X = [i for i∈1:N, j∈1:N]
const Y = [j for i∈1:N, j∈1:N]
const α₁ = float.(X.≥80)

#const Mx = full(Tridiagonal([1.0 for i in 1:N-1],[-2.0 for i in 1:N],[1.0 for i in 1:N-1]))
const Mx = Tridiagonal([1.0 for i in 1:N-1],[-2.0 for i in 1:N],[1.0 for i in 1:N-1])
const My = copy(Mx)
Mx[2,1] = 2.0
Mx[end-1,end] = 2.0
My[1,2] = 2.0
My[end,end-1] = 2.0

# Define the initial condition as normal arrays
A = zeros(N,N); B  = zeros(N,N); C = zeros(N,N)
u0 = ArrayPartition((A,B,C))

const MyA = zeros(N,N);
const AMx = zeros(N,N);
const DA = zeros(N,N)
# Define the discretized PDE as an ODE function
function f(du,u,p,t)
  A,B,C = u.x
  dA,dB,dC = du.x
  mul!(MyA,My,A)
  mul!(AMx,A,Mx)
  @. DA = D*(MyA + AMx)
  @. dA = DA + α₁ - β₁*A - r₁*A*B + r₂*C
  @. dB = α₂ - β₂*B - r₁*A*B + r₂*C
  @. dC = α₃ - β₃*C + r₁*A*B - r₂*C
end

# Solve the ODE
prob = ODEProblem(f,u0,(0.0,100.0))
@time sol = solve(prob,BS3(),progress=true,save_everystep=false,save_start=false)

# using Plots; gr()
# p1 = surface(X,Y,sol[end].x[1],title = "[A]")
# p2 = surface(X,Y,sol[end].x[2],title = "[B]")
# p3 = surface(X,Y,sol[end].x[3],title = "[C]")
