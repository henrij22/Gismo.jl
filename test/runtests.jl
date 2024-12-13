using Gismo
using Test

@testset verbose = true "Gismo.jl" begin
    @testset verbose = true "bases" begin
        @testset "constructors" begin
            @test_nowarn(KV = Gismo.KnotVector([0.,0.,0.,1.,1.,1.]))
            KV = Gismo.KnotVector([0.,0.,0.,1.,1.,1.])
            @test_nowarn(TBB = Gismo.TensorBSplineBasis(KV,KV))
            TBB = Gismo.TensorBSplineBasis(KV,KV)
            @test_nowarn(THB = Gismo.THBSplineBasis(TBB))
            THB = Gismo.THBSplineBasis(TBB)
        end

        # @testset "print" begin
        #     KV = Gismo.KnotVector([0.,0.,0.,1.,1.,1.])
        #     TBB = Gismo.TensorBSplineBasis(KV,KV)
        #     THB = Gismo.THBSplineBasis(TBB)

        #     oldstd = stdout
        #     redirect_stdout(devnull)
        #     @test_nowarn(print(KV))
        #     @test_nowarn(print(TBB))
        #     @test_nowarn(print(THB))
        #     redirect_stdout(oldstd) # recover original stdout
        # end

        @testset "refinement" begin
            KV = Gismo.KnotVector([0.,0.,0.,1.,1.,1.])
            TBB = Gismo.TensorBSplineBasis(KV,KV)
            THB = Gismo.THBSplineBasis(TBB)
            @test_nowarn(Gismo.uniformRefine(TBB))
            @test_nowarn(Gismo.uniformRefine(THB))
            boxes = Matrix{Cdouble}([0.0 0.5; 0.0 0.5])
            @test_nowarn(Gismo.refine(THB,boxes))
            boxes = Vector{Int32}([1,0,0,2,2])
            @test_nowarn(Gismo.refineElements(THB,boxes))
        end


    end
    @testset verbose = true "splines" begin
        @testset "constructors" begin
            KV = Gismo.KnotVector([0.,0.,0.,1.,1.,1.])
            TBB = Gismo.TensorBSplineBasis(KV,KV)
            THB = Gismo.THBSplineBasis(TBB)

            coefs_TBB = rand(Gismo.size(TBB),3)
            @test_nowarn(TB = Gismo.TensorBSpline(TBB,coefs_TBB))
            coefs_THB = rand(Gismo.size(THB),3)
            @test_nowarn(THB = Gismo.TensorBSpline(THB,coefs_THB))
        end

        @testset "evaluation" begin
            KV = Gismo.KnotVector([0.,0.,0.,1.,1.,1.])
            TBB = Gismo.TensorBSplineBasis(KV,KV)
            THB = Gismo.THBSplineBasis(TBB)
            coefs_TBB = rand(Gismo.size(TBB),3)
            TB = Gismo.TensorBSpline(TBB,coefs_TBB)
            coefs_THB = rand(Gismo.size(THB),3)
            THB = Gismo.TensorBSpline(THB,coefs_THB)

            N = 10
            points1D = range(0,stop=1,length=N)
            points2D = zeros(2,N*N)
            points2D[1,:] = repeat(points1D, N)
            points2D[2,:] = repeat(points1D, inner=N)
            @test_nowarn(ev = Gismo.asMatrix(Gismo.val(TB,points2D)))
            @test_nowarn(ev = Gismo.asMatrix(Gismo.val(THB,points2D)))
        end
    end
end