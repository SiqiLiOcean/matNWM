%==========================================================================
% matNWM package
%   Load Route Link 
%
% input  :
% 
% output :
%
% Siqi Li, SMAST
% 2023-03-17
%
% Updates:
%
%==========================================================================
function hgrid = h_extract_link(hgrid0, varargin)

varargin = read_varargin(varargin, {'Boundary'}, {[]});
varargin = read_varargin2(varargin, {'Single_removed'});


if ~isempty(Boundary)
    xv = Boundary(:,1);
    yv = Boundary(:,2);
    
    mouth0 = [hgrid0.rt.mouth];
    in = inpolygon(hgrid0.lon(mouth0), hgrid0.lat(mouth0), xv, yv);
    mouth = unique(mouth0(in));

    k = ismember(mouth0, mouth);

    hgrid = hgrid0;
    hgrid.rt = hgrid0.rt(k);

end

if Single_removed
    k = find([hgrid.rt.n]==1);
    hgrid.rt(k) = [];
end