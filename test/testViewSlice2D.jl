using Test
using jInvVis
using jInv.Mesh

# tests for regular mesh
domain = [0 1.1 0 1.0 0  1.1]
n      = [8 5 3]
Mr    = getRegularMesh(domain,n)

xc    = getCellCenteredGrid(Mr)
println("=== test viewSlice2D  ===")
figure(1); clf()
subplot(1,3,1)
viewSlice2D(xc[:,1],Mr,Int(round(n[3]/2)))
xlabel("x, intensity increases --> ")
ylabel("intensity constant")
title("f(x,y,z) = x")

subplot(1,3,2)
viewSlice2D(xc[:,1],Mr,Int(round(n[2]/2)),view=:xz,addLabel=true)
xlabel("x, intensity increases --> ")
title("f(x,y,z) = x")

subplot(1,3,3)
viewSlice2D(xc[:,2],Mr,Int(round(n[1]/2)),view=:yz,addLabel=true)
xlabel("y, intensity increases --> ")
title("f(x,y,z) = y")
