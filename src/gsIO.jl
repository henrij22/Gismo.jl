export
    OptionList,
    destroy!
    show
    #= TODO =#

########################################################################
# gsOptionList
########################################################################

mutable struct OptionList
    ptr::Ptr{gsCOptionList}

    function OptionList(opt::Ptr{gsCOptionList},delete::Bool=true)
        b = new(opt)
        if (delete)
            finalizer(destroy,b)
        end
        return b
    end

    function OptionList(options::Dict)
        opt = ccall((:gsOptionList_new,libgismo),Ptr{gsCOptionList},(),)
        # Empty string
        desc::String = ""
        for (key,value) in options
            if (typeof(value) == String)
                ccall((:gsOptionList_addString,libgismo),Cvoid,(Ptr{gsCOptionList},Cstring,Cstring,Cstring),opt,key,desc,value)
            elseif (typeof(value) == Int)
                ccall((:gsOptionList_addInr,libgismo),Cvoid,(Ptr{gsCOptionList},Cstring,Cstring,Cint),opt,key,desc,value)
            elseif (typeof(value) == Float64)
                ccall((:gsOptionList_addReal,libgismo),Cvoid,(Ptr{gsCOptionList},Cstring,Cstring,Cdouble),opt,key,desc,value)
            elseif (typeof(value) == Bool)
                ccall((:gsOptionList_addSwitch,libgismo),Cvoid,(Ptr{gsCOptionList},Cstring,Cstring,Cint),opt,key,desc,Int(value))
            else
                error("OptionList: Unsupported type for value")
            end
        end
        return OptionList(opt)
    end

    function destroy!(opt::OptionList)
        ccall((:gsOptionList_delete,libgismo),Cvoid,(Ptr{gsCOptionList},),opt.ptr)
    end
end

Base.show(io::IO, obj::OptionList) = ccall((:gsOptionList_print,libgismo),Cvoid,(Ptr{gsCOptionList},),obj.ptr)


