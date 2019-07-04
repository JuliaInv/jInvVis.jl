export viewOrthoSlices2D

"""
	function jInv.Vis.viewOrthoSlices2D

	visualizes 3D image by orthogonal slices

	Input:

		I    - image
		Mesh - tensor mesh describing image domain

	Optional Input:

		slices    - vector describing which slices to show, default: Mesh.n/2
		axis      - show axis label (useful to clarify how image is presented)
		linewidth - width of dividing lines
		color     - color of dividing lines
		cmap      - colormap
		vmin/vmax - specify intensity range
"""
function viewOrthoSlices2D(I,Mesh::AbstractTensorMesh;slices=Int.(round.(Mesh.n/2)),axis=false,linewidth=2,color="w",cmap="jet",vmin=minimum(I),vmax=maximum(I))

    #  create big image
    I   = reshape(I,tuple(Mesh.n...));
    Ixz = I[:,slices[2],:];   # xz view
    Iyz = I[slices[1],:,:]; # yz view
    Ixy = I[:,:,slices[3]]; # xy view

    Ibl = reverse(Ixy,dims=2)
    Ibr = reverse(Iyz,dims=1)'
    Itl = reverse(Ixz,dims=2)
    Itr = fill(0,Mesh.n[3],Mesh.n[3])
    I   = [Itl Ibl; Itr Ibr]

    # put together x and y axis of plot
    x,y,z = getNodalAxes(Mesh)
    xa = [vec(x);z[2:end].+maximum(x)]
    ya = [vec(y);z[2:end].+maximum(y)]

    domain = [x[1] x[end] y[1] y[end] z[1] z[end]]
    # plot image
    pcolormesh(xa,ya,reverse(I',dims=1),cmap=cmap,vmin=vmin,vmax=vmax)

    # add labels to clarify axis
    axis && xlabel("|-- x -- | -- z -- |")
    axis && ylabel("|-- y -- | -- z -- |")

    #     draw lines
	xc = .5*(x[slices[1]] + x[slices[1]+1])
	yc = .5*(y[slices[2]] + y[slices[2]+1])
	zc = .5*(z[slices[3]] + z[slices[3]+1])
    plot([0;maximum(xa)],[domain[4];domain[4]],linewidth=linewidth,color=color)
    plot([domain[2]; domain[2]],[0;maximum(ya)],linewidth=linewidth,color=color)
    plot([0;maximum(xa)],[yc;yc],"--",linewidth=linewidth,color=color)
 plot([0;maximum(x)],[zc;zc].+domain[4],"--",linewidth=linewidth,color=color);
  plot([xc;xc],[0;maximum(ya)],"--",linewidth=linewidth,color=color);	    plot([zc;zc].+domain[2],[0;maximum(y)],"--",linewidth=linewidth,color=color);

end
