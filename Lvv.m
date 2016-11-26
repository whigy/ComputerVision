function pixels = Lvv( inpic, shape)
%LVV Calculates the second order derivative 
%   Default by simple difference approximation
if (nargin < 2)
    shape = 'same';
end

dxmask = [1, -2, 1];
dymask = dxmask';

Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);
pixels = sqrt(Lx.^2 + Ly.^2);
end

