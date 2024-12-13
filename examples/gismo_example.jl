using Gismo





m = EigenMatrix(3,3)
setZero!(m)
display(asMatrix(m))

geom = Geometry( "surfaces/simple.xml" )
println("Geometry:")
println(geom)
println("Domain dim: ", domainDim(geom) )
println("Target dim: ", targetDim(geom) )

pts = zeros((2, 3))
pts[:,2] .= 0.5;
pts[:,3] .= 0.99;
println("Evaluation points:")
display(pts)

println("Evaluation result:")
values = val(geom,pts)
println("Rows: ", rows(values) )
println("Cols: ", cols(values) )

vals = asMatrix(values)
display(vals)
pts2 = invertPoints(geom,vals)
display(asMatrix(pts2))

normals = normal(geom,pts)
println("Normals at points:")
display(asMatrix(normals))

display(asMatrix(values)[:,1])
dist,par = closest(geom,asMatrix(values)[:,1])
display(asMatrix(par))


# basis = Basis( "filedata/bspbasis/tpBSpline2_01.xml" )
# println("Basis:")
# println(basis)

# values = val(basis,pts)
# println("Rows: ", rows(values) )
# println("Cols: ", cols(values) )
# vals = asMatrix(values)
# display(vals)

kv = KnotVector([0.,0.,0.,0.,0.5,1.,1.,1.,1.])
basis = TensorBSplineBasis(kv,kv)
println("Basis:")
println(basis)

values = val(basis,pts)
println("Rows: ", rows(values) )
println("Cols: ", cols(values) )
vals = asMatrix(values)
display(vals)

coefs = rand(size(basis),3)
geom = TensorBSpline(basis,coefs)
values = val(geom,pts)
println("Rows: ", rows(values) )
println("Cols: ", cols(values) )
vals = asMatrix(values)
display(vals)

uniformRefine!(basis)
println("Basis (refined):")
println(basis)

display(actives(basis,pts))

display(asMatrix(coefs(geom)))

THBSplineBasis(basis)
values = val(basis,pts)
println("Rows: ", rows(values) )
println("Cols: ", cols(values) )
vals = asMatrix(values)
display(vals)

mp = MultiPatch()
addPatch(mp,geom)
display(mp)
patch = patch(mp,0)
display(patch)

display(basis(mp,0))
display(uniformRefine!(basis(mp,0)))
display(basis(mp,0))



# display(dist)

# knots = [0.0,0.0,0.5,1.0,1.0]
# kv = KnotVector(knots)
# println("KnotVector:")
# println(kv)
# println("\n")

#basis = TensorBSplineBasis(kv,kv)
#println(basis)

#basis = THBSplineBasis(basis)
#println(basis)

#coefs = zeros((4, 3))
#geom = THBSpline(basis,coefs)
#println(geom)
