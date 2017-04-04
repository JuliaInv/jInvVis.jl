using Base.Test
using jInvVis
using jInv.Mesh
using PyPlot

# tests for regular mesh
domain = [1 2 0 .1 3 4]
n      = [8 5 3]
M2D    = getRegularMesh(domain[1:4],n[1:2])
M3D    = getRegularMesh(domain,n)

println("=== test plotGrid (regular mesh) ===")
figure(1)
plotGrid(M2D)
figure(2)
plotGrid(M3D)
figure(3)
plotGrid(getCellCenteredGrid(M2D),M2D);
println("==== all passed === ")
