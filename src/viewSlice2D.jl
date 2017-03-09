export viewSlice2D

"""
function jInv.Vis.getGridSlice

generates a slice of a 3D grid

Required Inputs:

    M::RegularMesh - mesh that describes geometry
    idx::Int       - slice index

Optional Inputs:
    
    view::Symbol   - possible choices :xy (default), :yz, :xz

"""
function getGridSlice(M::RegularMesh,idx,view=:xy)  
    if view==:xy
        return getRegularMesh(M.domain[1:4], M.n[1:2])
    elseif view==:yz
        return getRegularMesh(M.domain[3:6], M.n[2:3])
    elseif view==:xz
        return getRegularMesh(M.domain[[1:2;5:6]], M.n[[1;3]])
    end
end

"""
function jInv.Vis.viewSlice2D

plots a slice of a 3D data set using viewImage2D and PyPlot.pcolormesh

Required Inputs:

    Img            - image data to be visualized (assumed to be cell-centered)
    M::RegularMesh - mesh that describes geometry
    idx::Int       - slice index

Optional Inputs:

    view::Symbol   - possible choices :xy (default), :yz, :xz
    addLabel::Bool - print axis labels (default=false)
    kwargs         - keyword arguments for PyPlot.pcolormesh

"""
function viewSlice2D(Img,M::RegularMesh,idx::Int;view=:xy,addLabel::Bool=false,kwargs...)
    
    if idx<1; error(BoundsError); end
    Img = reshape(Img,tuple(M.n...))
    if view==:xy
        if idx>M.n[3]; error(BoundsError); end;
        I2D = Img[:,:,idx]
        putLabels = () -> (xlabel("x"); ylabel("y"))
    elseif view==:yz
        if idx>M.n[1]; error(BoundsError); end;
        I2D = Img[idx,:,:]
        putLabels = () -> (xlabel("y"); ylabel("z"))
    elseif view==:xz
        if idx>M.n[2]; error(BoundsError); end;
        I2D = Img[:,idx,:]
        putLabels = () -> (xlabel("x"); ylabel("z"))
    end 
    
    M2D = getGridSlice(M,idx,view)
    viewImage2D(I2D,M2D;kwargs...)
    
    addLabel && putLabels()
end