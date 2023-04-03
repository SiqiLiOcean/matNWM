%==========================================================================
% matNWM package
%   Draw NWM route link figure
%
% input  :
%   h --- nwm grid
%
% output :
%   p --- patch handle
%
% Siqi Li, SMAST
% 2023-03-20
%
% Updates:
%
%==========================================================================
function [p1, p2] = h_2d_point(h, varargin)

varargin = read_varargin(varargin, {'Color'}, {'y'});

rt = h.rt;
lon = h.lon;
lat = h.lat;

point = unique([rt.link]);
px = lon(point);
py = lat(point);
mouth = unique([rt.mouth]);
mx = lon(mouth);
my = lat(mouth);

hold on
p1 = plot(px, py, 'o', 'MarkerSize', 1.2, ...
                      'MarkerFaceColor', Color, ...
                      'MarkerEdgeColor', Color);
p2 = plot(mx, my, 'o', 'MarkerSize', 1.5, ...
                      'MarkerFaceColor', Color, ...
                      'MarkerEdgeColor', 'k');


if ~isempty(varargin)
    set(p1, varargin{:})
    set(p2, varargin{:})
end