function my_monte_carlo_pi(n)
    r = 0
    for i=1:n
        x=rand(Uniform(-1,1))
        y=rand(Uniform(-1,1))
        if x^2+y^2<1
            r+=1
        end
    end
    my_pi = 4*r/n
    return my_pi
end
