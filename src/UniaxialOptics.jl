module UniaxialOptics


# natural constants (in SI units)
const ε0 = 8.85418781e-12   # vacuum permitivity (F/m)
const c = 299792458         # speed of light (m/s)


"""Flips the sign of `x` if `imag(x) < 0` to enforce `imag(x) >= 0`."""
posimag(x) = imag(x) < 0 ? -x : x


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
