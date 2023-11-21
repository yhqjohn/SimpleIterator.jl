# SimpleIterator

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://yhqjohn.github.io/SimpleIterator.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://yhqjohn.github.io/SimpleIterator.jl/dev/)
[![Build Status](https://github.com/yhqjohn/SimpleIterator.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/yhqjohn/SimpleIterator.jl/actions/workflows/CI.yml?query=branch%3Amain)

SimpleIterator.jl is a Julia package that provides a simple Python-like iterator interface for Julia.
It enables the iteration of an object `x` becomes iteration over `iterator(x)`.
The iteration behavior can be easily customized by overloading the `iterator` function and returning the desired iterator object.

```julia
struct MyType
    data::Vector{Int}
end

@iterfn iterator(x::MyType) = x.data

for i in MyType([1, 2, 3])
    @show i
end
```

## Installation

```julia
] add SimpleIterator
```
