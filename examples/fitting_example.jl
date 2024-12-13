using Gismo
using DelimitedFiles
using Plots

# Create the knot vector
KV = KnotVector([0.,0.,0.,1.,1.,1.])
# Load the points and their parameters
pars_file::String = "../try_gismo/julia/filedata/shiphull_pars.csv"
points_file::String = "../try_gismo/julia/filedata/shiphull_points.csv"
pars = readdlm(pars_file, ',', Float64)
points = readdlm(points_file, ',', Float64)
# Define the basis using the knots
BB2 = TensorBSplineBasis(KV,KV)
# Create the fitter
fitter = Fitting(pars,points,BB2)
# Perform the least squares error approssimation
compute!(fitter)
# Compute the errors
computeErrors!(fitter)
# Display the outputs
println(minPointError(fitter))
println(maxPointError(fitter))
println(pointWiseErrors(fitter))
println(unsafe_wrap(Vector{Float64}, pointWiseErrors(fitter), 264, own=false))
println(numPointsBelow(fitter, 0.02))
# Obtain the geometry
geo = result(fitter)
# Create a matrix of linearly spaced evaluation points
N = 10
points1D = range(0,stop=1,length=N)
points2D = zeros(2,N*N)
# Create a meshgrid of evaluation points
points2D[1,:] = repeat(points1D, N)
points2D[2,:] = repeat(points1D, inner=N)

ev = asMatrix(val(geo,points2D))

# Plot the geometry
surface!(ev[1,:],ev[2,:],ev[3,:],legend=false)
gui()
# Press enter to exit
println("Press enter to exit!")
readline()