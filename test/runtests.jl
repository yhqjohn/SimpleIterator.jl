using SimpleIterator
using Test

# Define a type to test the iterator macro
struct MyType
    data::Vector{Int}
end

# Define the iterator function for MyType
@iterfn iterator(x::MyType) = x.data
SimpleIterator.IteratorType(::Type{MyType}) = Vector{Int}

# Define the tests
@testset "Iterator Tests" begin
    # Test iterating over MyType
    @testset "Iteration" begin
        mt = MyType([1, 2, 3])
        expected = [1, 2, 3]
        actual = [i for i in mt]
        @test actual == expected
    end

    # Test IteratorSize
    @testset "IteratorSize" begin
        mt = MyType([1, 2, 3])
        expected = Base.HasShape{1}()
        actual = Base.IteratorSize(mt)
        @test actual == expected
    end

    # Test IteratorEltype
    @testset "IteratorEltype" begin
        mt = MyType([1, 2, 3])
        expected = Base.HasEltype()
        actual = Base.IteratorEltype(mt)
        @test actual == expected
    end

    # Test eltype
    @testset "Eltype" begin
        mt = MyType([1, 2, 3])
        expected = Int
        actual = Base.eltype(mt)
        @test actual == expected
    end

    # Test length function
    @testset "Length" begin
        mt = MyType([1, 2, 3])
        expected = 3
        actual = length(mt)
        @test actual == expected
    end

    # Test size function
    @testset "Size" begin
        mt = MyType([1, 2, 3])
        expected = (3,)
        actual = size(mt)
        @test actual == expected
    end

    # Test isdone function
    @testset "Is Done" begin
        mt = MyType([1, 2, 3])
        @test !isempty(mt)
    end
end

# Test the iterator macro with different function definition styles
@testset "Iterator Macro" begin
    # Test the iterator macro with `function` style function definition
    @testset "Equal Sign" begin
        struct MyType2
            data::Vector{Int}
        end
        @iterfn function iterator(x::MyType2)
            return x.data
        end
        mt = MyType2([1, 2, 3])
        @test [i for i in mt] == [1, 2, 3]
    end

    # Test the iterator macro with `function` style function definition with `where` clause
    @testset "Equal Sign with Where Clause" begin
        struct MyType3{T}
            data::Vector{T}
        end
        @iterfn function iterator(x::MyType3{T}) where {T}
            return x.data
        end
        mt = MyType3([1, 2, 3])
        @test [i for i in mt] == [1, 2, 3]
    end

    # Test the iterator macro with `=` style function definition with `where` clause
    @testset "Equal Sign with Where Clause" begin
        struct MyType4{T}
            data::Vector{T}
        end
        @iterfn (iterator(x::MyType4{T})) where {T} = x.data
        mt = MyType4([1, 2, 3])
        @test [i for i in mt] == [1, 2, 3]
    end
end
