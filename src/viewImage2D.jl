export viewImage2D

"""
	function jInv.Vis.viewImage2D

	visualizes 2D image on mesh

	Input:

	I - image data
	M - 2 dimensional AbstractTensorMesh

	kwargs get piped to pcolormesh
"""
function viewImage2D(I,M::AbstractTensorMesh;kwargs...)
	if M.dim!=2
		error("viewImage2D supports only 2-dimensional images")
	end
	I = reshape(I,tuple(M.n...))
	x1,x2 = getCellCenteredAxes(M)
	return heatmap(x1,x2,I';kwargs...)
end
