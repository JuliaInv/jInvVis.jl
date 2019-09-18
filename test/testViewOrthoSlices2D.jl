using Test
using jInvVis
using jInv.Mesh

# tests for regular mesh
domain = [0 1.1 0 1.0 0  1.1]
n      = [8 5 3]
Mr    = getRegularMesh(domain,n)
Mt    = getTensorMesh3D(rand(n[1]),rand(n[2]),rand(n[3]))
I     = randn(tuple(n...))
println("=== test viewOrthoSlices  ===")
figure(2)
viewOrthoSlices2D(I,Mr)
figure(1)
viewOrthoSlices2D(I,Mt)
println("==== all passed === ")
