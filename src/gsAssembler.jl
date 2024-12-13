export
    QuadRule,
    destroy!,
    show
    #= TODO =#

########################################################################
# gsQuadRule
########################################################################

mutable struct QuadRule
    ptr::Ptr{gsCQuadRule}

    function QuadRule(quad::Ptr{gsCQuadRule},delete::Bool=true)
        b = new(quad)
        if (delete)
            finalizer(destroy!,b)
        end
        return b
    end

    function destroy!(qr::QuadRule)
        ccall((:gsQuadRule_delete,libgismo),Cvoid,(Ptr{gsCQuadRule},),qr.ptr)
    end
end

Base.show(io::IO, obj::QuadRule) = ccall((:gsQuadRule_print,libgismo),Cvoid,(Ptr{gsCQuadRule},),obj.ptr)

