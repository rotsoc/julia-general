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

traverse(ex) = ex  # generally do nothing
traverse(ex::Symbol) = ex==:x ? :(x+1) : ex # for the symbol :x make it :(x+1)
traverse(ex::Expr) = Expr(:call,traverse.(ex.args)...) # Expressions are done recursively


traverse!(ex) = ex  # generally do nothing
traverse!(ex::Symbol) = ex==:x ? :(x+1) : ex # for the symbol :x make it :(x+1)
traverse!(ex::Expr) = (ex.args.=traverse!.(ex.args); ex)

ex = :(x^2+1)
traverse!(ex)
ex

# Exercise: Make the traverse! function more general,
# to replace x by an arbitrary expression that is another argument of the function.

function traverse!(ex::Expr, ex2::Expr)
    args = ex.args
    for i in 1:length(args)
        @show i, args[i]

        if isa(args[i], Expr)
            traverse!(args[i],ex2)

        elseif args[i] == :x
            args[i] = ex2
        end
    end
end

function Dollar(ex::Expr)
end

function wrap_literals(ex::Expr,f::Symbol)
    println("Entering!")
    @show ex
    args = ex.args
    for i in 1:length(args)
        @show i, args[i]
        args[i] = wrap_literals(args[i], f)
    end
    return ex
end

wrap_literals(x::Number, f::Symbol) = :($f($x))
wrap_literals(x,f) = x # fall-back method

p_5(x) = (x-1) * (x-2) * (x-3) * (x-4) * (x-5)

function wp(n::Int)
    ex = :(x-$n)
    for i=n-1:-1:1
        ex = :($ex*(x-$i))
    end
    return ex
end
