using Test
using jInvVis
using jInv.Mesh
using Plots

# tests for regular mesh
domain = [1 2 0 .1 3 4]
n      = [81 70 30]
M2D    = getRegularMesh(domain[1:4],n[1:2])
m2D    = ones(tuple(M2D.n...))
M3D    = getRegularMesh(domain,n)
m3D    = ones(tuple(M3D.n...))

println("=== test plotModel (regular mesh) ===")
figure()
plotModel(m2D,true,M2D,2,[0.8,1.2]);

figure()
plotModel(m3D,true,M3D,2,[0.8,1.2]);

println("==== all passed === ")
