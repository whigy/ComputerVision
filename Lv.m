function pixels = Lv(inpic, op, shape)

if (nargin < 2)
    op = 'cdo';
    shape = 'same';
elseif(nargin == 2)
    shape = 'same';
end

sdo_x = [-1, 0, 1];
sdo_y = sdo_x';

cdo_x = sdo_x ./2;
cdo_y = sdo_y ./2;

robert_x = [-1, 0;
             0, 1];
robert_y = [0, -1;
            1, 0];
        
sobel_x = [
    -1 0 1
    -2 0 2
    -1 0 1];
sobel_y = sobel_x';

dxmask = eval([op,'_x']);
dymask = eval([op,'_y']);

Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);
pixels = sqrt(Lx.^2 + Ly.^2);