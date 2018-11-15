function logisticmap(N)
    r=2.9
    t=1
    y_r = zeros(Int((4-2.9)/0.001),150)
    while (r<=4)
        b=zeros(N+2)
        b[1]=0.25
        for i=1:N+1
            b[i+1]=r*b[i]*(1-b[i])
        end
        bn=b[N+2]
        y_r[t,:]=steady(r,bn)
        r+=0.001
    end
    return y_r
end

function steady(r,bn)
    y=zeros(150)
    y[1]=bn
    for i=1:149
        y[i+1]=r*y[i]*(1-y[i])
    end
    return y
end

y=logisticmap(400)
plot(y)
