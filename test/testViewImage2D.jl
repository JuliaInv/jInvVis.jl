using Base.Test
using jInvVis
using jInv.Mesh
using PyPlot

# tests for regular mesh
domain = [0 1.1 0 1.0 ]
n      = [8 5 ]
Mr    = getRegularMesh(domain,n)
I     = randn(tuple(n...))
xc    = getCellCenteredGrid(Mr)

println("=== test viewImage2D  ===")
figure(2)
subplot(1,2,1)
viewImage2D(xc[:,1],Mr)
xlabel("intensity increases -->")
ylabel("constant intensity")
subplot(1,2,2)
viewImage2D(xc[:,2],Mr)
ylabel("intensity increases -->")
xlabel("constant intensity")
println("==== all passed === ")
