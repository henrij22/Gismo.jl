export
    Fitting
    #= TODO =#

########################################################################
# gsFitting
########################################################################

mutable struct Fitting
    ptr::Ptr{gsCFitting}

    function Fitting(opt::Ptr{gsCFitting},delete::Bool=true)::Fitting
        b = new(opt)
        if (delete)
            finalizer(destroy,b)
        end
        return b
    end

    function Fitting(parValues::Matrix{Cdouble}, pts::Matrix{Cdouble}, basis::Basis)::Fitting
        @assert Base.size(parValues,2) == Base.size(pts,2) "Fitting: parValues and points must have the same number of columns"
        param_values = EigenMatrix(Base.size(parValues,1),Base.size(parValues,2),pointer(parValues))
        points = EigenMatrix(Base.size(pts,1),Base.size(pts,2),pointer(pts))
        fitter = ccall((:gsFitting_create,libgismo),Ptr{gsCFitting},(Ptr{EigenMatrix},Ptr{EigenMatrix},Ptr{gsCBasis}),param_values.ptr,points.ptr,basis.ptr)
        return Fitting(fitter)
    end

    function destroy(fit::Fitting)
        ccall((:gsFitting_delete,libgismo),Cvoid,(Ptr{gsCFitting},),fit.ptr)
    end
end

function compute(fit::Fitting, lambda::Cdouble=0.0)
    ccall((:gsFitting_compute,libgismo),Cvoid,(Ptr{gsCFitting},Cdouble),fit.ptr,lambda)
end

#= TODO:
    gsFitting_parameterCorrection
    gsFitting_computeErrors
    gsFitting_minPointError
    gsFitting_maxPointError
    gsFitting_pointWiseErrors
    gsFitting_numPointsBelow
 =#

function result(fit::Fitting)::Geometry
    geom = ccall((:gsFitting_result,libgismo),Ptr{gsCGeometry},(Ptr{gsCFitting},),fit.ptr)
    return Geometry(geom)
end