using Test

# Import the module containing the iterator macro
include("/d:/Documents/GitHub/SimpleIterator/src/SimpleIterator.jl")

# Define a type to test the iterator macro
struct MyType
    data::Vector{Int}
end

# Define the iterator function for MyType
@iterfn iterator(x::MyType) = x.data

# Define the tests
@testset "Iterator Tests" begin
    # Test iterating over MyType
    @testset "Iteration" begin
        mt = MyType([1, 2, 3])
        expected = [1, 2, 3]
        actual = [i for i in mt]
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
        expected = false
        actual = isdone(mt)
        @test actual == expected
    end
end