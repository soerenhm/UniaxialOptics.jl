
struct PropagationInvariant
    ω  :: Float64   # frequency
    kx :: Float64   # x-momentum
end

invariant(ω::Real, kx::Real) = PropagationInvariant(float(ω), float(kx))
invariant(ω::Real; angle::Real=0.0) = PropagationInvariant(ω, wavenumber(ω)*sind(angle))

wavenumber(ω::Real) = ω/c
wavenumber(p::PropagationInvariant) = wavenumber(p.ω)
wavenumber(p::PropagationInvariant, ε::Number) = posimag(sqrt(ε)) * wavenumber(p)

wavenumber2(ω::Real) = wavenumber(ω)^2
wavenumber2(p::PropagationInvariant) = wavenumber2(p.ω)
wavenumber2(p::PropagationInvariant, ε::Number) = ε * wavenumber2(p)

wavevector(p::PropagationInvariant) = p.kx, posimag(sqrt(wavenumber2(p) - p.kx^2))
wavevector(p::PropagationInvariant, ε::Number) = p.kx, posimag(sqrt(wavenumber2(p, ε) - p.kx^2))

direction(p::PropagationInvariant) = rad2deg(asin(p.kx / wavenumber(p)))
function direction(p::PropagationInvariant, ε)
    kx, kz = wavevector(p, ε)
    return rad2deg(atan(real(kz), kx))  # does this make sense for complex kz?
end
