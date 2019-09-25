
export plotModel, cutBoundaryLayer




"""
function plotModel

	plots model on a regular mesh

	Requirement: PyPlot must be installed.

	Parameters:
	m 				:: model. 2D or 3D Array.
	includeMeshInfo	:: A boolean indicating whether to include distances info (in KMs) in the image. Relevant only in 2D.
	cutPad			:: A flag for cutting the outmost layer. If cutPad == 0, there's no cutting.
	limits			:: Maximum and minimum values in the colorbar.
	filename        :: A filename for automatically saving the image as a file.
"""
function plotModel(m::Union{Array{Float64},Array{Float32}},includeMeshInfo::Bool=false,M_regular = [],cutPad::Int64 = 0,limits = [],filename="")

if limits!=[]
	vmin = limits[1];
	vmax = limits[2];
else
	vmin = minimum(m);
	vmax = maximum(m);
end

limits = tuple([vmax,vmin]...);
if cutPad > 0
	m,M_regular = cutBoundaryLayer(m,M_regular,cutPad);
end
	if length(size(m))==2
		T = m';
		imshow(T, clim = limits,cmap = "jet"); colorbar();
		if includeMeshInfo
			Omega = M_regular.domain;
			tics = 0:2:floor(Int64,Omega[2])
			# xticks(linspace(0,size(m,1)*tics[end]/Omega[2],length(tics)),tics);
			xlabel("Lateral distance (km)");
			tics = 0:floor(Int64,Omega[4])
			# println(tics)
			# println(linspace(0,size(m,2)*tics[end]/Omega[4],length(tics)))
			# yticks(linspace(0,size(m,2)*tics[end]/Omega[4],length(tics)),tics);
			ylabel("Depth (km)")
		end
		if filename != ""
			savefig(string(filename[1:end-4],".png"));
		end
	elseif length(size(m))==3
		lin = zeros(Int64,16);
		v = m;
		for k=1:16
			lin[k] = Int(round(k*(size(m,2)/16)));
		end
		for k=1:16
			subplot(string("44",k))
			pic = reshape(v[:,lin[k],:],size(m,1),size(m,3))';
			imshow(pic,clim = limits); title(string("frame",lin[k]));colorbar()
		end
		if filename != ""
			savefig(string(filename[1:end-4],".png"));
		end
	end
return;
end

"""
function cutBoundaryLayer

	Removes the boundary layer from the model and returns the cut model and a corresponding new mesh.
	Used mostly for plotting - sometimes we prefer not to show the boundary of the model.

	The "boundary" here is all the boundaries of the regular domain except the top surface.


	Parameters:
	m 				:: model. 2D or 3D Array.
	M_regular		:: A corresponding regular mesh.
	pad			    :: The thickness of the layer in cells.

"""
function cutBoundaryLayer(m::Array{Float64},M_regular,pad::Int64)
if pad<=0
	return m,M_regular;
end
Omega = M_regular.domain;
if length(size(m))==2
	mnew = m[pad+1:end-pad,1:end-pad];
	nnew = collect(size(mnew)).-1;
	OmegaNew = [Omega[1],Omega[2] - 2*pad*M_regular.h[1],Omega[3],Omega[4]-pad*M_regular.h[2]];
	MshNew = getRegularMesh(OmegaNew,nnew);
elseif length(size(m))==3
	mnew = m[pad+1:end-pad,pad+1:end-pad,1:end-pad];
	nnew = collect(size(mnew)).-1;
	OmegaNew = [Omega[1],Omega[2] - 2*pad*M_regular.h[1],Omega[3],Omega[4]-2*pad*M_regular.h[2],Omega[4],Omega[5]-pad*M_regular.h[3]];
	MshNew = getRegularMesh(OmegaNew,nnew);
end
return mnew,MshNew
end
