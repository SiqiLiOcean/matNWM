%==========================================================================
% Draw NWM routelink in KML
%
% input  : wgrid --- WRF grid cell
%          fout  --- output path and name
%          'Model'     --- name displayed in Google Earth
%          'LineWidth' --- line width
%          'LineColor' --- line color ('r', 'red' or [255 0 0])
% 
% output : \
%
% Siqi Li, SMAST
% 2021-06-09
%
% Updates:
%
%==========================================================================
function k = kml_h_boundary(rt, fout, varargin)

% Default settings:
varargin = read_varargin(varargin, {'Model'}, {'NWM RouteLink'});
varargin = read_varargin(varargin, {'LineWidth'}, {2.2});
% varargin = read_varargin(varargin, {'LineColor'}, {'FFFFFFFF'});
varargin = read_varargin(varargin, {'LineColor'}, {[255 255 255]});
switch class(LineColor)
case 'char'
    RGB = COLOR2RGB(LineColor);
    LineColor = RGB2ABGR(255, RGB);
case 'double'
    LineColor = RGB2ABGR(255, LineColor);
otherwise
    error('Unknown LineColor')
end



varargin = read_varargin(varargin, {'Xlims'}, {[-Inf Inf]});
varargin = read_varargin(varargin, {'Ylims'}, {[-Inf Inf]});
varargin = read_varargin(varargin, {'Head'}, {[]});
varargin = read_varargin(varargin, {'Mouth'}, {[]});

n = length(rt);

if isinf(Xlims(2))
    k1 = true(1, n);
else
    k1 = [rt.bound_l]<=Xlims(2);
end
if isinf(Xlims(1))
    k2 = true(1, n);
else
    k2 = [rt.bound_r]>=Xlims(1);
end
if isinf(Ylims(2))
    k3 = true(1, n);
else
    k3 = [rt.bound_b]<=Ylims(2);
end
if isinf(Ylims(1))
    k4 = true(1, n);
else
    k4 = [rt.bound_t]>=Ylims(1);
end
if isempty(Head)
    k5 = true(1, n);
else
    k5 = ismember([rt.head], Head);
end
if isempty(Mouth)
    k6 = true(1, n);
else
    k6 = ismember([rt.mouth], Mouth);
end


flag = all([k1; k2; k3; k4; k5; k6]);
flag = find(flag);



k = kml(Model);
for i = 1 : length(flag)

x = rt(flag(i)).x(1:end-1);
y = rt(flag(i)).y(1:end-1);

k.plot(x, y,   ...
           'altitude', 0,              ...
           'altitudeMode', 'absolute', ...
            'lineWidth', LineWidth,     ...
            'lineColor', LineColor,     ...
            'name', 'NWM RouteLink');

end
k.save(fout);


end


function ABGR = RGB2ABGR(alpha, RGB)
% RGB   : 1 ~ 255
% alpha : 1 ~ 255
    ABGR = [dec2hex(alpha,2) dec2hex(RGB(3),2) dec2hex(RGB(2),2) dec2hex(RGB(1),2)];
    
end
function RGB = COLOR2RGB(COLOR)
% COLOR : char
% RGB   : 1 ~ 255

    switch COLOR
        case {'red', 'r'}
            RGB = [255 0 0];
        case {'green', 'g'}
            RGB = [0 255 0];
        case {'blue', 'b'}
            RGB = [0 0 255];
        case {'cyan', 'c'}
            RGB = [0 255 255];
        case {'magenta', 'm'}
            RGB = [255 0 255];
        case {'yellow', 'y'}
            RGB = [255 255 0];
        case {'black', 'k'}
            RGB = [0 0 0];
        case {'white', 'w'}
            RGB = [255 255 255];
        otherwise
            error(['Unknown color code: ' COLOR])
    end
    
end