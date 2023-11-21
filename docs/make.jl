using SimpleIterator
using Documenter

DocMeta.setdocmeta!(SimpleIterator, :DocTestSetup, :(using SimpleIterator); recursive=true)

makedocs(;
    modules=[SimpleIterator],
    authors="yhqjohn <25428156+yhqjohn@users.noreply.github.com> and contributors",
    repo="https://github.com/yhqjohn/SimpleIterator.jl/blob/{commit}{path}#{line}",
    sitename="SimpleIterator.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://yhqjohn.github.io/SimpleIterator.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
    warnonly = true,
)

deploydocs(;
    repo="github.com/yhqjohn/SimpleIterator.jl",
    devbranch="main",
)
