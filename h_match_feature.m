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
function match = h_match_feature(hgrid, fchrtout, varargin)

lon = ncread(fchrtout, 'longitude');
lat = ncread(fchrtout, 'latitude');

match = knnsearch([lon lat], [hgrid.lon hgrid.lat]);
