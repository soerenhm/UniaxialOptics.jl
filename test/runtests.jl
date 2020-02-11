using UniaxialOptics
using Test
import UniaxialOptics: value, value_xx, value_zz, gradient

@testset "UniaxialOptics.jl" begin
    # Write your own tests here.
end



struct Air <: Permittivity{Isotropic,Constant} end
value(ε::Air, ω::Real) = 1.0 + 0im

struct Linear <: Permittivity{Isotropic,Variable} end
value(ε::Linear, ω::Real, z::Real) = (1.0 + 0im)*z
gradient(ε::Linear, ω::Real, z::Real) = 1.0 + 0im

struct Birefringent <: Permittivity{Uniaxial,Constant} end
value_xx(ε::Birefringent, ω::Real) = 2.8 + 0im
value_zz(ε::Birefringent, ω::Real) = 2.2 + 0im


@testset "permittivity" begin
    ω = 1.0

    air = Air()
    @test value(air, ω) == value_xx(air, ω) == value_yy(air, ω) == value_zz(air, ω) == 1.0 + 0im
    @test gradient(air, ω) == gradient_xx(air, ω) == gradient_yy(air, ω) == gradient_zz(air, ω) == 0.0 + 0im

    lin = Linear()
    @test value(lin, ω, 0.0) == 0.0 + 0im
    @test value(lin, ω, 1.0) == 1.0 + 0im
    @test gradient(lin, ω, 0.0) == 1.0 + 0im
    @test gradient(lin, ω, 1.0) == 1.0 + 0im

    bir = Birefringent()
    @test value_xx(bir, ω) == value_yy(bir, ω) == 2.8 + 0im
    @test value_zz(bir, ω) == 2.2 + 0im
    @test gradient_xx(bir, ω) == gradient_yy(bir, ω) == gradient_zz(bir, ω) == 0.0 + 0im

end
