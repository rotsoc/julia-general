# What is metaprogramming
# function func_foo(n::Int)
#     for i=1:n
#         println("foo")
#     end
# end
# function func_bar(n::Int)
#     for i=1:n
#         println("bar")
#     end
# end
# function func_baz(n::Int)
#     for i=1:n
#         println("baz")
#     end
# end
for sym in [:foo,:bar,:baz]
    @eval function $(Symbol(string("func_",sym)))(n::Int)
        for i=1:n
            println($(string(sym)))
        end
    end
end

function wp(n::Int)
    ex = :(x-$n)
    for i=n-1:-1:1
        ex = :($ex*(x-$i))
    end
    return ex
end
