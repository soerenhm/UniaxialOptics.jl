
abstract type CrystalClass end
struct Isotropic <: CrystalClass end
struct Uniaxial <: CrystalClass end
struct Biaxial <: CrystalClass end

# NOTE no support for biaxial materials...!


abstract type SpatialDependence end
struct Constant <: SpatialDependence end # spatial gradient in permittivity = 0
struct Variable <: SpatialDependence end # spatial gradient in permittivity ≂̸ 0

const ConstOrVar = Union{Constant,Variable}



abstract type Permittivity{CC<:CrystalClass,SD<:ConstOrVar} end

Base.broadcastable(ε::Permittivity) = Ref(ε)

# handles the special case of a permittivity constant in space (i.e. gradient = 0)
value_xx(ε::Permittivity{CC,Constant}, ω::Real, z::Real) where CC<:CrystalClass = value_xx(ε, ω)
value_yy(ε::Permittivity{CC,Constant}, ω::Real, z::Real) where CC<:CrystalClass = value_yy(ε, ω)
value_zz(ε::Permittivity{CC,Constant}, ω::Real, z::Real) where CC<:CrystalClass = value_zz(ε, ω)

gradient_xx(ε::Permittivity{CC,Constant}, ω::Real) where CC<:CrystalClass = zero(Complex{typeof(ω)})
gradient_yy(ε::Permittivity{CC,Constant}, ω::Real) where CC<:CrystalClass = zero(Complex{typeof(ω)})
gradient_zz(ε::Permittivity{CC,Constant}, ω::Real) where CC<:CrystalClass = zero(Complex{typeof(ω)})

gradient_xx(ε::Permittivity{CC,Constant}, ω::Real, z::Real) where CC<:CrystalClass = gradient_xx(ε, ω)
gradient_yy(ε::Permittivity{CC,Constant}, ω::Real, z::Real) where CC<:CrystalClass = gradient_yy(ε, ω)
gradient_zz(ε::Permittivity{CC,Constant}, ω::Real, z::Real) where CC<:CrystalClass = gradient_zz(ε, ω)

# handles isotropic materials; no need to distinguish xx, yy and zz
value_xx(ε::Permittivity{Isotropic,Constant}, ω::Real) = value(ε, ω)
value_yy(ε::Permittivity{Isotropic,Constant}, ω::Real) = value(ε, ω)
value_zz(ε::Permittivity{Isotropic,Constant}, ω::Real) = value(ε, ω)
value(ε::Permittivity{Isotropic,Constant}, ω::Real, z::Real) = value(ε, ω)

value_xx(ε::Permittivity{Isotropic,Variable}, ω::Real, z::Real) = value(ε, ω, z)
value_yy(ε::Permittivity{Isotropic,Variable}, ω::Real, z::Real) = value(ε, ω, z)
value_zz(ε::Permittivity{Isotropic,Variable}, ω::Real, z::Real) = value(ε, ω, z)

gradient(ε::Permittivity{Isotropic,Constant}, ω::Real) = zero(Complex{typeof(ω)})
gradient(ε::Permittivity{Isotropic,Constant}, ω::Real, z::Real) = gradient(ε, ω)

gradient_xx(ε::Permittivity{Isotropic,Variable}, ω::Real, z::Real) = gradient(ε, ω, z)
gradient_yy(ε::Permittivity{Isotropic,Variable}, ω::Real, z::Real) = gradient(ε, ω, z)
gradient_zz(ε::Permittivity{Isotropic,Variable}, ω::Real, z::Real) = gradient(ε, ω, z)

# handles uniaxial materials; xx and yy components are the same.
value_yy(ε::Permittivity{Uniaxial,Constant}, ω::Real) = value_xx(ε, ω)
value_yy(ε::Permittivity{Uniaxial,Variable}, ω::Real, z::Real) = value_xx(ε, ω, z)

gradient_yy(ε::Permittivity{Uniaxial,Variable}, ω::Real, z::Real) = gradient_xx(ε, ω, z)
