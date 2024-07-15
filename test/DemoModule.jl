"Demo functions for testing"
module DemoModule
export foo, bar, qux

"""
    foo

This is a global variable
"""
foo = 5

"""
    bar

_This_ is a function.
"""
bar() = 5

"""
    qux

This function **just** calls [`bar`])(@ref).
"""
qux() = bar()

end  # module