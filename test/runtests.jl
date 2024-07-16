module tests

using Readmes
using Test
using ReferenceTests

@eval Main include("DemoModule.jl")
@eval Main using .DemoModule


@testset "Readmes.jl" begin
    @test_reference(
        "references/DemoReadme_small.md",
        generate_readme(String, joinpath(@__DIR__, "DemoReadme_small.template.md"))
    )
    @test_reference(
        "references/DemoReadme_large.md",
        generate_readme(String, joinpath(@__DIR__, "DemoReadme_large.template.md"))
    )
end

end  # moduleq