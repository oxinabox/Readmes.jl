using Readmes
using Test
using ReferenceTests

@eval Main include("DemoModule.jl")
@eval using .DemoModule

@testset "Readmes.jl" begin
    @test_reference(
        "references/DemoReadme_small.md",
        generate_readme(String, "DemoReadme_small.template.md")
    )
    @test_reference(
        "references/DemoReadme_large.md",
        generate_readme(String, "DemoReadme_large.template.md")    
    )
end
