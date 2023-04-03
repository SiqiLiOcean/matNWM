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
function w = interp_bilinear_calc_weight(x1, y1, x2, y2)

ix = find(x2>=x1(1) & x2<=x1(end));
iy = find(y2>=y1(1) & y2<=y1(end));

w.wx = interp_time_calc_weight(x1, x2(ix));
w.wy = interp_time_calc_weight(y1, y2(iy));

w.ix = ix;
w.iy = iy;
w.nx = length(x2);
w.ny = length(y2);