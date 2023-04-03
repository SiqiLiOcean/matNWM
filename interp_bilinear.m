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
function var2 = interp_bilinear(var1, x1, y1, x2, y2, varargin)

w = interp_bilinear_calc_weight(x1, y1, x2, y2);

var2 = interp_bilinear_via_weight(var1, w, varargin);
