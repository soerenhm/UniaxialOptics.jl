module UniaxialOptics

greet() = print("Hello World...!")


export
    Permittivity,
    Isotropic,
    Uniaxial,
    Constant,
    Variable,

    invariant,
    wavenumber,
    wavenumber2,
    wavevector,
    direction,

    value,
    value_xx,
    value_yy,
    value_zz,

    gradient,
    gradient_xx,
    gradient_yy,
    gradient_zz


include("invariants.jl")
include("permittivity.jl")

end # module
