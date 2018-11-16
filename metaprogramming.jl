using MacroTools

:a, :b, :c, :foo, :α, :call # These are all symbols
:(a+1),:(sin(b)),:(c(10)),:(foo(a,b,c)),:(foo(α^2+1)) # These are all expressions

ex = :(x+3)

ex.args[2] = :z
ex.args[3] = 4

ex.args[1] = :*

Meta.show_sexpr(ex)

ex2 = :(x + 3y)

Meta.show_sexpr(ex2)

Meta.parse("x+3y")

ex = :(x + 3x^2)

# dump(ex)
#
# function traverse!(ex::Expr)
#
#     args = ex.args
#
#     for i in 1:length(args)
#
#         if args[i] == :x
#             args[i] = :(x+1)
#         end
#
#     end
#
# end

ex = :(x + 3x^2)

# function traverse!(ex::Expr)
#
#     args = ex.args
#
#     for i in 1:length(args)
#         @show i, args[i]
#         if args[i] == :x
#             args[i] = :(x+1)
#         end
#     end
# end


Meta.show_sexpr(ex)

function traverse!(ex::Expr)

    args = ex.args

    for i in 1:length(args)
        @show i, args[i]

        if isa(args[i], Expr)
            traverse!(args[i])

        elseif args[i] == :x
            args[i] = :(x+1)
        end
    end
end
