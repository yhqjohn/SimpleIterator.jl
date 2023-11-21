```@meta
CurrentModule = SimpleIterator
```

# SimpleIterator

Documentation for [SimpleIterator.jl](https://github.com/yhqjohn/SimpleIterator.jl).

SimpleIterator.jl is a Julia package that provides a simple Python-like iterator interface for Julia.
It enables the iteration of an object `x` becomes iteration over `iterator(x)`.
The iteration behavior can be easily customized by overloading the `iterator` function and returning the desired iterator object.

```@index
```

```@docs
@iterfn
iterator
IteratorType
```
