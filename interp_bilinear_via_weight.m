%==========================================================================
% matFVCOM package
% 
%
% input  :
% 
% output :
%
% Siqi Li, SMAST
% yyyy-mm-dd
%
% Updates:
%
%==========================================================================
function var2 = interp_bilinear_via_weight(var1, w, varargin)

varargin = read_varargin2(varargin, {'Shrink'});

wx = w.wx;
wy = w.wy;
ix = w.ix;
iy = w.iy;

% Interpolate on x dimension
weight = repmat(wx.w(:),1,size(var1,2));
tmp = var1(wx.it,:).*weight + var1(wx.it+1,:).*(1-weight);

% Interpolate on y dimension
weight = repmat(wy.w(:)',size(tmp,1),1);
tmp = tmp(:,wy.it).*weight + tmp(:,wy.it+1).*(1-weight);

if ~isempty(Shrink)
    var2 = tmp;
else
    var2 = nan(w.nx, w.ny);
    var2(w.ix, w.iy) = tmp;
end