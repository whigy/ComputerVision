function pixels= Lvvtilde_filter(inpic, shape)

if (nargin < 2)
    shape = 'same';
end

dxmask = [-0.5, 0, 0.5];
dxmask = zeros(5, 5);
dxmask(3, 2:4) = [-0.5, 0, 0.5];
dymask = dxmask';

dxxmask = zeros(5, 5);
dxxmask(3, 2:4) = [1, -2, 1];
dyymask = dxxmask';

dxymask = filter2(dxmask,dymask,'same'); 

Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);
Lxx = filter2(dxxmask, inpic, shape);
Lyy = filter2(dyymask, inpic, shape);
Lxy = filter2(dxymask, inpic, shape);
pixels = Lx.^2 .* Lxx + 2 * Lx .* Ly .* Lxy + Ly.^2 .* Lyy;