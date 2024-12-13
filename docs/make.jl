# Check dependencies
neededPackages = [:Documenter, :Example, :gismo_jll]
using Pkg;

for neededpackage in neededPackages
    (String(neededpackage) in keys(Pkg.project().dependencies)) || Pkg.add(String(neededpackage))
    @eval using $neededpackage
end

push!(LOAD_PATH, "../src/")
using Gismo

DocMeta.setdocmeta!(Gismo,
                    :DocTestSetup,
                    :(using Gismo;),
                    recursive = true)

# List of subsection pages
SUBSECTION_PAGES = [
    "gsCore.md",
    "gsNurbs.md",
    "gsHSplines.md"
]

makedocs(
    sitename = "Gismo.jl",
    modules  = [Gismo],
    pages = [
        "Home" => "index.md",
        "Modules" => SUBSECTION_PAGES
    ]
)
