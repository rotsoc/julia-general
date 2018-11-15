function generate_data(T,alpha)
    x=zeros(T+2)
    for t=1:T+1
        x[t+1]=alpha*x[t]+randn()
    end
    return x
end

y=generate_data(200,0.0)
z=generate_data(200,0.5)
k=generate_data(200,0.9)

plot!(y,label="alpha=0.0")
plot!(z,label="alpha=0.5")
plot!(k,label="alpha=0.9")
