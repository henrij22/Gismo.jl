using BenchmarkTools
using BenchmarkPlots

using Gismo

KV = Gismo.KnotVector([0.,0.,0.,1.,1.,1.])
TBB = Gismo.TensorBSplineBasis(KV,KV)
Gismo.uniformRefine(TBB)
coefs = rand(Gismo.size(TBB),3)
TB = Gismo.TensorBSpline(TBB,coefs)

display(@benchmark normal(TB,rand(Float64, (2, 1))))
display(@benchmark Gismo.val(TB,rand(Float64, (2, 1))))



