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
function p = h_2d_route(h, varargin)

% varargin = read_varargin(varargin, {'Xlims'}, {[-Inf Inf]});
% varargin = read_varargin(varargin, {'Ylims'}, {[-Inf Inf]});
% varargin = read_varargin(varargin, {'Head'}, {[]});
% varargin = read_varargin(varargin, {'Mouth'}, {[]});
varargin = read_varargin(varargin, {'Color'}, {[]});
% 
rt = h.rt;
% 
% n = length(rt);
% 
% if isinf(Xlims(2))
%     k1 = true(1, n);
% else
%     k1 = [rt.bound_l]<=Xlims(2);
% end
% if isinf(Xlims(1))
%     k2 = true(1, n);
% else
%     k2 = [rt.bound_r]>=Xlims(1);
% end
% if isinf(Ylims(2))
%     k3 = true(1, n);
% else
%     k3 = [rt.bound_b]<=Ylims(2);
% end
% if isinf(Ylims(1))
%     k4 = true(1, n);
% else
%     k4 = [rt.bound_t]>=Ylims(1);
% end
% if isempty(Head)
%     k5 = true(1, n);
% else
%     k5 = ismember([rt.head], Head);
% end
% if isempty(Mouth)
%     k6 = true(1, n);
% else
%     k6 = ismember([rt.mouth], Mouth);
% end
% 
% 
% k = all([k1; k2; k3; k4; k5; k6]);
% 
% 
% x = [rt(k).x];
% y = [rt(k).y];
% order = double([rt(k).order]);
x = [rt.x];
y = [rt.y];


if isempty(Color)
    order = double([rt.order]);
    p = patch(x, y, x*0, order, 'edgecolor', 'interp', 'linewidth', 1.5);
else
    p = plot(x, y, 'linewidth', 1.5, 'color', Color);
end

if ~isempty(varargin)
    set(p, varargin{:})
end