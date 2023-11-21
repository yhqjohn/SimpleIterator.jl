module SimpleIterator

using MacroTools

function iterator end
IteratorType(::Any) = Any


"""
    @iterfn

Define a iterator for a type. The type should have a function named `iterator` which returns a iterator.
After the macro is called, iteration over the type will automatically becomes iteration over the iterator.

# Arguments

- `fundef`: function definition to be decorated, the function name should be `iterator`.

# Example

```julia
struct MyType
    data::Vector{Int}
end

@iterfn iterator(x::MyType) = x.data

for i in MyType([1, 2, 3])
    println(i)
end
```
"""
macro iterfn(fundef)
    sig = MacroTools.splitdef(fundef)
    args = sig[:args]
    length(args) == 1 || error("Only one argument is allowed for iterator function")
    arg = args[1]
    # capture the type annotation
    @capture(arg, (argname_::anno_)|(::anno_))||error("`iterate` function should have only one argument, with bounded type annotation")
    bounds = sig[:whereparams]
    name = get(sig, :name, nothing)
    kwargs = get(sig, :kwargs, nothing)
    rtype = get(sig, :rettype, nothing)

    if name === nothing
        throw(ArgumentError("Iterator function name is required"))
    elseif name !== :iterator
        throw(ArgumentError("Iterator function name must be `iterator`"))
    end

    if kwargs != []
        throw(ArgumentError("Iterator function should not have keyword arguments"))
    end

    rst = quote
        $fundef

        function Base.iterate(x::$anno) where {$(bounds...)}
            _iterator = iterator(x)
            next = iterate(_iterator)
            if next === nothing
                return nothing
            else
                result, state = next
                state = (_iterator, state)
                return result, state
            end
        end

        function Base.iterate(::$anno, state) where {$(bounds...)}
            _iterator, state = state
            next = iterate(_iterator, state)
            if next === nothing
                return nothing
            else
                result, state = next
                state = (_iterator, state)
                return result, state
            end
        end

        Base.IteratorSize(::Type{$anno}) where {$(bounds...)} = Base.IteratorSize(IteratorType($anno))
        Base.IteratorEltype(::Type{$anno}) where {$(bounds...)} = Base.IteratorEltype(IteratorType($anno))
        Base.eltype(::Type{$anno}) where {$(bounds...)} = Base.eltype(IteratorType($anno))
        Base.length(x::$anno) where {$(bounds...)} = Base.length(iterator(x))
        Base.size(x::$anno) where {$(bounds...)} = Base.size(iterator(x))
        Base.isdone(x::$anno) where {$(bounds...)} = Base.isdone(iterator(x))
        Base.isdone(::$anno, state) where {$(bounds...)} = Base.isdone(state...)
    end
    return esc(rst)
end

export @iterfn, IteratorType, iterator

end # module

