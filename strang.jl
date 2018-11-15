function strang_mine(N)
    A = zeros(N,N)
    for i=1:N
        for j=1:N
            if i==j
                A[i,j]=-2
            elseif abs(i-j)==1
                A[i,j]=1
            end
        end
    end
    return A
end

function strang_sol(N)
    A = zeros(N,N)
    for i=1:N,j=1:N
        abs(i-j)<=1 && (A[i,j] += 1.0)
        i==j && (A[i,j] -= 3.0)
    end
    return A
end
