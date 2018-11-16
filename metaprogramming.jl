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
