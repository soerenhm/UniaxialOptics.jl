
abstract type AbstractEMField end
# abstract type ElectricField <: AbstractEMField end
# abstract type MagneticField <: AbstractEMField end


struct FieldValue
    Fx :: Complex{Float64}
    Fy :: Complex{Float64}
    Fz :: Complex{Float64}
end


struct ElectricField <: EMField
    invar :: PropagationInvariant
    value :: FieldValue
    gradient ::
end

struct MagneticField <: EMField
    invar :: PropagationInvariant
    value :: FieldValue
end


struct Propagator{P <: Permittivity}
    ε :: P
end

function (𝒫::Propagator{P} where P <: Permittivity{Isotropic,Constant})(E::ElectricField, z1::Real, z2::Real)
    
end
# end


function propagate(field::AbstractEMField, z1::Real, z2::Real) end # free space
function propagate(field::AbstractEMField, z1::Real, z2::Real, ε::Permittivity) end
