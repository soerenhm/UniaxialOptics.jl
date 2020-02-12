using UniaxialOptics
using Test

import UniaxialOptics: posimag, c


@testset "invariants" begin

    @test posimag(1.0 - 1.0im) == -1.0 + 1.0im

    invar1 = invariant(c, angle=30.0)
    invar2 = invariant(c, angle=90.0)
    kx1, kz1 = wavevector(invar1)
    kx2, kz2 = wavevector(invar2)
    @test kx1 == 0.5
    @test kx2 == 1.0
    @test kz1 ≈ sqrt(0.75)
    @test kz2 == 0.0
    @test direction(invar1) ≈ 30.0
    @test direction(invar2) ≈ 90.0
end
