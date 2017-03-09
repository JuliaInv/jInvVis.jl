"""
module jInvVis

Visualization tools for jInv

"""

module jInvVis
    
    using jInv.Mesh

    hasPyPlot = false
    try
        using PyPlot
        hasPyPlot = true
    catch
    end

    hasJOcTree = false
    try
      using JOcTree
      hasJOcTree = true
    catch
    end

    hasMATLAB = false
    try
        using MATLAB
        hasMATLAB = true
    catch
    end

    
    if hasPyPlot
        include("plotGrid.jl");
        include("viewImage2D.jl");
        include("viewOrthoSlices2D.jl");
        include("plotModel.jl");
        include("viewSlice2D.jl");
    end

    if hasJOcTree & hasMATLAB
        include("plotOcTreeMesh.jl")
    end

    export hasPyPlot, hasJOcTree, hasMATLAB
end
