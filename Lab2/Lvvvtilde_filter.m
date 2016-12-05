function pixels = Lvvvtilde_filter(inpic, shape)

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

dxxxmask = filter2(dxmask, dxxmask, 'same'); %conv? filter?
dxxymask = filter2(dxxmask, dymask, 'same');
dxyymask = filter2(dxmask, dyymask, 'same');
dyyymask = filter2(dymask, dyymask, 'same');

Lx = filter2(dxmask, inpic, shape); %conv? filter?
Ly = filter2(dymask, inpic, shape);
Lxxx = filter2(dxxxmask, inpic, shape);
Lxxy = filter2(dxxymask, inpic, shape);
Lxyy = filter2(dxyymask, inpic, shape);
Lyyy = filter2(dyyymask, inpic, shape);
pixels = Lx.^3 .* Lxxx + 3 * Lx.^2 .* Ly .* Lxxy + 3 * Lx .* Ly.^2 .* Lxyy + Ly.^3 .* Lyyy;