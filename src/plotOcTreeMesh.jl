export plotOctree

function plotOctree(mesh::OcTreeMesh; f = 1)
    
    u = round(Int,log2(nonzeros(mesh.S)) .+ 1)
    
    plotOctree(mesh, u; f = f)
    
    return
end

function plotOctree(mesh::OcTreeMesh, u::Array{Int64,1}; f = 1)

    # to avoid incompatibilities between Julia's and Matlab's sparse3 we pass the indices and values
    i,j,k,bsz = find3(mesh.S)
    n         = mesh.n
    h         = mesh.h
    x0        = mesh.x0

    # set path to Matlab function plotOcTree.m which resides in the same directory like this Julia function
    (dname,fname) = splitdir(@__FILE__())
    mxcall(:addpath, 0, dname)

    # plot
    mxcall(:plotOcTreeMesh, 0, f, i, j, k, bsz, n, h, x0, u)

    return

end

function plotOctree(mesh::OcTreeMesh, u::Array{Float64,1}; f = 1)

    # to avoid incompatibilities between Julia's and Matlab's sparse3 we pass the indices and values
    i,j,k,bsz = find3(mesh.S)
    n         = mesh.n
    h         = mesh.h
    x0        = mesh.x0

    # set path to Matlab function plotOcTree.m which resides in the same directory like this Julia function
    (dname,fname) = splitdir(@__FILE__())
    mxcall(:addpath, 0, dname)

    # plot
    mxcall(:plotOcTreeMesh, 0, f, i, j, k, bsz, n, h, x0, u)

    return

end
