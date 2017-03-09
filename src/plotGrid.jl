export plotGrid


"""
function plotGrid

	plots nodal and cell-centered grids

	Requirement: PyPlot must be installed.

	Usage:

	plotGrid(M::AbstractTensorMesh) - plots nodal grid M
	plotGrid(x,M)                   - plots grid defined by x (nodal or cc)

	plotGrid is based on PyPlot.plot and PyPlot.plot3D. All keywords from those functions
	are available and forwarded to those methods.
	
"""
function plotGrid(y,M;spacing=[1,1,1],color="b",kwargs...)

    if length(y)==M.dim*prod(M.n)
        nn = M.n
    elseif length(y)==M.dim*prod(M.n+1)
        nn = M.n+1
    else
        error("plotGrid - unknown grid type, length(y)=$(length(y)), n=$(M.n), dim=$(M.dim)")
    end
    Y = reshape(y,(prod(nn),M.dim))
    yi(d) = reshape(Y[:,d],tuple(nn...))
    if M.dim==2
        J1 = 1:spacing[1]:nn[1]; y1 = reshape(yi(1),tuple(nn...));
        J2 = 1:spacing[2]:nn[2]; y2 = reshape(yi(2),tuple(nn...));
        p1 = plot(y1[:,J2],y2[:,J2]; color=color,  kwargs...);
        p2 = plot(y1[J1,:]',y2[J1,:]';color=color,  kwargs...);
    elseif M.dim==3
        pt1 = p3(yi(1),yi(2),yi(3),nn,[1 2 3],spacing; color=color, kwargs...)
        pt2 = p3(yi(1),yi(2),yi(3),nn,[2,1,3],spacing; color=color, kwargs...);
        pt3 = p3(yi(1),yi(2),yi(3),nn,[3,1,2],spacing; color=color, kwargs...);
	else
		error("plotGrid - cannot handle $(M.dim)-dimensional grids")
    end
end

plotGrid(M::AbstractMesh;kwargs...) = plotGrid(getNodalGrid(M),M;kwargs...)

"""
function p3

	helper function for plotGrid

"""
function p3(y1,y2,y3,m,order,s;kwargs...)
    m  = m[order];
    s  = s[order];
    y(x)  =  reshape(permutedims(x,order),(m[1],m[2]*m[3]));
    y1    = y(y1); y2 = y(y2); y3 = y(y3);
    dx = round(Int64,m./s);
    J2 = 1:s[2]:m[2];
    J3 = 1:s[3]:m[3];
    K2 = collect(J2)*ones(Int64,1,length(J3));
    K3 = ones(Int64,length(J2),1)*(m[2]*(collect(J3)-1))'
    K  = vec(K2)+vec(K3);
    for k=1:length(K)
        plot3D(y1[:,K[k]],y2[:,K[k]], y3[:,K[k]];kwargs...)
    end
end
