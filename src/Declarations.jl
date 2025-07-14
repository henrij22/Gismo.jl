########################################################################
# CTypes
########################################################################

# Matrix
mutable struct gsCMatrix end
mutable struct gsCMatrixInt end
mutable struct gsCVector end
mutable struct gsCVectorInt end
mutable struct gsCSparseMatrix end

# Core
mutable struct gsCFunctionSet end
mutable struct gsCMultiPatch end
mutable struct gsCMultiBasis end
mutable struct gsCBasis end
mutable struct gsCGeometry end
mutable struct gsCFunctionExpr end

# NURBS
mutable struct gsCKnotVector end

# Assembler
mutable struct gsCQuadRule end

# ΙO
mutable struct gsCOptionList end

# Modeling
mutable struct gsCFitting end

# Pde
mutable struct gsCBoundaryConditions end

####### SUBMODULES
# Submodules are declared within their own files,
# such that this file does not need to change when submodules are added.

# For example, the gsKLShell submodule is declared in gsKLShell.jl
# gsKLShell
# mutable struct gsCMaterialMatrixBase end
# mutable struct gsCThinShellAssemblerBase end
