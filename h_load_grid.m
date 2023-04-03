%==========================================================================
% matNWM package
%   Load grid
%
% input  :
%   frt    --- Route Link input file
%   Np     --- number of processors. If >0, then use
%   MaxLen 
%   Single_removed
% 
% output :
%   hgrid
%
% Siqi Li, SMAST
% 2023-03-17
%
% Updates:
%
%==========================================================================
function hgrid = h_load_grid(frt, varargin)


hgrid.lon = ncread(frt, 'lon');
hgrid.lat = ncread(frt, 'lat');

hgrid.rt = h_load_link(frt, varargin{:});

