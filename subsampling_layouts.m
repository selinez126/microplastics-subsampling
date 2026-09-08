clear all
close all
clc

% The goal is to create binary "masks" based on the grid layouts. So the
% areas to be subsampled from could be 1 and the rest is 0. These masks
% would be overlayed onto the image of interest and we can "edit" the
% original image in this sort of filtering way so we do an AND operation

% white = 1 = selected, black = 0 = not selected (I'm trying to make the
% first slice in the TL quadrant (if looking at it clock-wise) is chosen)
% Also, for equation-type internal boundaries we use < and >= solely

% Currently, .PNG masks of size dim x dim (4160 x 4160) will be created by
% running the following sections and the folder specified is one named
% 'layouts'. Note that the 'Spiral' section requires user input.
dim = 4160;

%% (1) Grid - split into 4 square quadrants and select 1 (top left, top
% right, bottom left, or bottom right)

for i = 1:4 % TL, TR, BL, BR
    mask = zeros(dim, dim); 
    if i == 1
        mask(1:dim/2, 1:dim/2) = 1;
    elseif i == 2
        mask(1:dim/2, dim/2:dim) = 1;
    elseif i == 3
        mask(dim/2:dim, 1:dim/2) = 1;
    elseif i == 4
        mask(dim/2:dim, dim/2:dim) = 1;
    end
    imwrite(mask, ['layouts/grid1_' num2str(i) '.PNG']);
    figure(); % Do this to display all images
    imshow(mask);
    title(['Grid mask with 4 squares (' num2str(i) ')']);
end

% Also doing with 16 squares and selecting 4
for i = 1:4
    mask = zeros(dim, dim);
    if i == 1
        mask(1:dim/4, 1:dim/4) = 1;
        mask(dim/2:dim*3/4, 1:dim/4)= 1;
        mask(1:dim/4, dim/2:dim*3/4) = 1;
        mask(dim/2:dim*3/4, dim/2:dim*3/4) = 1;
    elseif i == 2
        mask(1:dim/4, dim/4:dim/2) = 1;
        mask(dim/2:dim*3/4, dim/4:dim/2)= 1;
        mask(1:dim/4, dim*3/4:dim) = 1;
        mask(dim/2:dim*3/4, dim*3/4:dim) = 1;
    elseif i == 3
        mask(dim/4:dim/2, 1:dim/4) = 1;
        mask(dim*3/4:dim, 1:dim/4)= 1;
        mask(dim/4:dim/2, dim/2:dim*3/4) = 1;
        mask(dim*3/4:dim, dim/2:dim*3/4) = 1;
    elseif i == 4
        mask(dim/4:dim/2, dim/4:dim/2) = 1;
        mask(dim*3/4:dim, dim/4:dim/2)= 1;
        mask(dim/4:dim/2, dim*3/4:dim) = 1;
        mask(dim*3/4:dim, dim*3/4:dim) = 1;
    end
    imwrite(mask, ['layouts/grid4_' num2str(i) '.PNG']);
    figure(); % Do this to display all images
    imshow(mask);
    title(['Grid mask with 16 squares (' num2str(i) ')']);
end

% Then with 64 squares and selection of 16 squares
for i = 1:4
    mask = zeros(dim, dim);
    if i == 1
        mask(1:dim/8, 1:dim/8) = 1;
        mask(dim/4:dim*3/8, 1:dim/8) = 1;
        mask(dim/2:dim*5/8, 1:dim/8) = 1;
        mask(dim*3/4:dim*7/8, 1:dim/8) = 1;
        mask(1:dim/8, dim/4:dim*3/8) = 1;
        mask(dim/4:dim*3/8, dim/4:dim*3/8) = 1;
        mask(dim/2:dim*5/8, dim/4:dim*3/8) = 1;
        mask(dim*3/4:dim*7/8, dim/4:dim*3/8) = 1;
        mask(1:dim/8, dim/2:dim*5/8) = 1;
        mask(dim/4:dim*3/8, dim/2:dim*5/8) = 1;
        mask(dim/2:dim*5/8, dim/2:dim*5/8) = 1;
        mask(dim*3/4:dim*7/8, dim/2:dim*5/8) = 1;
        mask(1:dim/8, dim*3/4:dim*7/8) = 1;
        mask(dim/4:dim*3/8, dim*3/4:dim*7/8) = 1;
        mask(dim/2:dim*5/8, dim*3/4:dim*7/8) = 1;
        mask(dim*3/4:dim*7/8, dim*3/4:dim*7/8) = 1;
    elseif i == 2
        mask(1:dim/8, dim/8:dim*1/4) = 1;
        mask(dim/4:dim*3/8, dim/8:dim*1/4) = 1;
        mask(dim/2:dim*5/8, dim/8:dim*1/4) = 1;
        mask(dim*3/4:dim*7/8, dim/8:dim*1/4) = 1;
        mask(1:dim/8, dim*3/8:dim/2) = 1;
        mask(dim/4:dim*3/8, dim*3/8:dim/2) = 1;
        mask(dim/2:dim*5/8, dim*3/8:dim/2) = 1;
        mask(dim*3/4:dim*7/8, dim*3/8:dim/2) = 1;
        mask(1:dim/8, dim*5/8:dim*3/4) = 1;
        mask(dim/4:dim*3/8, dim*5/8:dim*3/4) = 1;
        mask(dim/2:dim*5/8, dim*5/8:dim*3/4) = 1;
        mask(dim*3/4:dim*7/8, dim*5/8:dim*3/4) = 1;
        mask(1:dim/8, dim*7/8:dim) = 1;
        mask(dim/4:dim*3/8, dim*7/8:dim) = 1;
        mask(dim/2:dim*5/8, dim*7/8:dim) = 1;
        mask(dim*3/4:dim*7/8, dim*7/8:dim) = 1;
    elseif i == 3
        mask(dim/8:dim*1/4, 1:dim/8) = 1;
        mask(dim*3/8:dim/2, 1:dim/8) = 1;
        mask(dim*5/8:dim*3/4, 1:dim/8) = 1;
        mask(dim*7/8:dim, 1:dim/8) = 1;
        mask(dim/8:dim*1/4, dim/4:dim*3/8) = 1;
        mask(dim*3/8:dim/2, dim/4:dim*3/8) = 1;
        mask(dim*5/8:dim*3/4, dim/4:dim*3/8) = 1;
        mask(dim*7/8:dim, dim/4:dim*3/8) = 1;
        mask(dim/8:dim*1/4, dim/2:dim*5/8) = 1;
        mask(dim*3/8:dim/2, dim/2:dim*5/8) = 1;
        mask(dim*5/8:dim*3/4, dim/2:dim*5/8) = 1;
        mask(dim*7/8:dim, dim/2:dim*5/8) = 1;
        mask(dim/8:dim*1/4, dim*3/4:dim*7/8) = 1;
        mask(dim*3/8:dim/2, dim*3/4:dim*7/8) = 1;
        mask(dim*5/8:dim*3/4, dim*3/4:dim*7/8) = 1;
        mask(dim*7/8:dim, dim*3/4:dim*7/8) = 1;
    elseif i == 4
        mask(dim/8:dim*1/4, dim/8:dim*1/4) = 1;
        mask(dim*3/8:dim/2, dim/8:dim*1/4) = 1;
        mask(dim*5/8:dim*3/4, dim/8:dim*1/4) = 1;
        mask(dim*7/8:dim, dim/8:dim*1/4) = 1;
        mask(dim/8:dim*1/4, dim*3/8:dim/2) = 1;
        mask(dim*3/8:dim/2, dim*3/8:dim/2) = 1;
        mask(dim*5/8:dim*3/4, dim*3/8:dim/2) = 1;
        mask(dim*7/8:dim, dim*3/8:dim/2) = 1;
        mask(dim/8:dim*1/4, dim*5/8:dim*3/4) = 1;
        mask(dim*3/8:dim/2, dim*5/8:dim*3/4) = 1;
        mask(dim*5/8:dim*3/4, dim*5/8:dim*3/4) = 1;
        mask(dim*7/8:dim, dim*5/8:dim*3/4) = 1;
        mask(dim/8:dim*1/4, dim*7/8:dim) = 1;
        mask(dim*3/8:dim/2, dim*7/8:dim) = 1;
        mask(dim*5/8:dim*3/4, dim*7/8:dim) = 1;
        mask(dim*7/8:dim, dim*7/8:dim) = 1;
    end
    imwrite(mask, ['layouts/grid16_' num2str(i) '.PNG']);
    figure(); % Do this to display all images
    imshow(mask);
    title(['Grid mask with 64 squares (' num2str(i) ')']);
end


%% (2) Wedge (Pie Slice)
options = [2, 4, 3];
for i = 1:3 % 8, 16, 12 slices total
    for j = 1:4 % 4 configurations 
        mask = zeros(dim, dim);
        for x = 1:dim
            for y = 1:dim
                if i == 1
                    if (j == 1)
                        if (x < dim/2 && y < dim/2 && y >= x) || (x >= dim/2 && y >= dim/2 && y < x)
                            mask(y, x) = 1;
                        end
                    elseif (j == 2)
                        if (x < dim/2 && y < dim/2 && y < x) || (x >= dim/2 && y >= dim/2 && y >= x)
                            mask(y, x)= 1;
                        end
                    elseif (j == 3)
                        if (x >= dim/2 && y < dim/2 && y < -x + dim) || (x < dim/2 && y >= dim/2 && y >= -x + dim)
                            mask(y, x) = 1;
                        end
                    elseif (j == 4)
                        if (x >= dim/2 && y < dim/2 && y >= -x + dim) || (x < dim/2 && y >= dim/2 && y < -x + dim)
                            mask(y, x) = 1;
                        end
                    end
                elseif i == 2
                    if (j == 1)
                        if (x < dim/2 && y < dim/2 && y >= 0.5 * x + 1040) || ... 
                                (x >= dim/2 && y < dim/2 && y < -2 * x + 6240) || ...
                                (x >= dim/2 && y >= dim/2 && y < 0.5 * x + 1040) || ...
                                (x < dim/2 && y >= dim/2 && y >= -2 * x + 6240)
                            mask(y, x) = 1;
                        end
                    elseif (j == 2)
                        if (x < dim/2 && y < dim/2 && y < 0.5 * x + 1040 && y >= x) || ...
                                (x >= dim/2 && y < dim/2 && y < -x + 4160 && y >= -2 * x + 6240) || ...
                                (x >= dim/2 && y >= dim/2 && y >= 0.5 * x + 1040 && y < x) || ...
                                (x < dim/2 && y >= dim/2 && y < -2 * x + 6240 && y >= -x + 4160)
                            mask(y, x) = 1;
                        end
                    elseif (j == 3)
                        if (x < dim/2 && y < dim/2 && y < x && y >= 2 * x - 2080) || ...
                                (x >= dim/2 && y < dim/2 && y >= -x +4160 && y < -0.5 * x + 3120) || ...
                                (x >= dim/2 && y >= dim/2 && y < 2 * x - 2080 && y >= x) || ...
                                (x < dim/2 && y >= dim/2 && y < -x + 4160 && y >= -0.5 * x + 3120)
                            mask(y, x) = 1;
                        end
                    elseif (j == 4)
                        if (x < dim/2 && y < dim/2 && y < 2 * x - 2080) || ...
                                (x >= dim/2 && y < dim/2 && y >= -0.5 * x + 3120) || ...
                                (x >= dim/2 && y >= dim/2 && y >= 2 * x - 2080) || ...
                                (x < dim/2 && y >= dim/2 && y < -0.5 * x + 3120)
                            mask(y, x) = 1;
                        end
                    end
                elseif i == 3
                    if (j == 1)
                        if (x >= dim/2 && y < dim/2 && y < -(1 / sqrt(3)) * x + (dim/2 * (1 + 1/sqrt(3))) && y >= -sqrt(3) * x + (dim/2 * (1 + sqrt(3)))) || ...
                                (x >= dim/2 && y >= dim/2 && y >= sqrt(3) * x - (dim/2*(sqrt(3) - 1))) || ...
                                (x < dim/2 && y < dim/2 && y >= (1 / sqrt(3)) * x + (dim/2 * (1 - 1/sqrt(3))))
                            mask(y, x) = 1;
                        end
                    elseif (j == 2)
                        if (x < dim/2 && y < dim/2 && y < (1 / sqrt(3)) * x + (2080 * (1 - 1/sqrt(3))) && y >= sqrt(3) * x - 2080*(sqrt(3) - 1)) || ...
                                (x >= dim/2 && y < dim/2 && y >= -(1 / sqrt(3)) * x + (2080 * (1 + 1/sqrt(3)))) || ...
                                (x < dim/2 && y >= dim/2 && y >= -sqrt(3) * x + (2080 * (1 + sqrt(3))))
                            mask(y, x) = 1;
                        end
                    elseif (j == 3)
                        if (x < dim/2 && y >= dim/2 && y >= -(1 / sqrt(3)) * x + (dim/2 * (1 + 1/sqrt(3))) && y < -sqrt(3) * x + (dim/2 * (1 + sqrt(3)))) || ...
                                (x >= dim/2 && y >= dim/2 && y < (1 / sqrt(3)) * x + (dim/2 * (1 - 1/sqrt(3)))) || ...
                                (x < dim/2 && y < dim/2 && y < sqrt(3) * x - (dim/2*(sqrt(3) - 1)))
                            mask(y, x) = 1;
                        end
                    elseif (j == 4)
                        if (x >= dim/2 && y < dim/2 && y < -sqrt(3) * x + (2080 * (1 + sqrt(3)))) || ...
                                (x >= dim/2 && y >= dim/2 && y < sqrt(3) * x - 2080*(sqrt(3) - 1) && y >= (1 / sqrt(3)) * x + (2080 * (1 - 1/sqrt(3)))) || ...
                                (x < dim/2 && y >= dim/2 && y < -(1 / sqrt(3)) * x + (2080 * (1 + 1/sqrt(3))))
                            mask(y, x) = 1;
                        end
                    end
                end
            end
        end
        imwrite(mask, ['layouts/wedge' num2str(options(i)) '_' num2str(j) '.PNG']);
    end
end


%% (3) Concentric Rings
% Sample from certain width rings along radius (or from the inner circle) at
% equal intervals of a circle such that the overall area equals that of a quadrant (2080^2 = 4326400)

% Either be allowed to set the width of the ring or the number of rings.
% But neither seem like they would work... very well that is. No I think
% setting the number of rings would work better - then there is probably
% some way to maximize the radius that is needed. Would also need to choose
% whether those rings start in the center or the perimeter (go out/in)

for i = 3:5 % 3, 4, 5 rings
    for j = 1:2 % outwards from center, inwards from perimeter
        mask = zeros(dim, dim);
        syms w;
        if (i == 3)
            if (j == 1)
                p = pi * w^2 + pi * (w + dim/6)^2 - pi * (dim/6)^2 + pi * (w + dim/3)^2 - pi * (dim/3)^2 - 2080^2;
                p_vec = sym2poly(expand(p));
                r = roots(p_vec);
                width = r(2);
                for x = 1:dim
                    for y = 1:dim
                        if (x - dim/2)^2 + (y - dim/2)^2 <= width^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/6)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/6 + width)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/3)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/3 + width)^2
                            mask(y, x) = 1;
                        end
                    end
                end
            elseif (j == 2)
                p = pi * (dim/2)^2 - pi * (dim/2 - w)^2 + pi * (dim/3)^2 - pi * (dim/3 - w)^2 + pi * (dim/6)^2 - pi * (dim/6 - w)^2 - 2080^2;
                p_vec = sym2poly(expand(p));
                r = roots(p_vec);
                width = r(2);
                for x = 1:dim
                    for y = 1:dim
                        if (x - dim/2)^2 + (y - dim/2)^2 >= (dim/6 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/6)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/3 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/3)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/2 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/2)^2
                            mask(y, x) = 1;
                        end
                    end
                end
            end
        elseif (i == 4)
            if (j == 1)
                p = pi * w^2 + pi * (w + dim/8)^2 - pi * (dim/8)^2 + pi * (w + dim/4)^2 - pi * (dim/4)^2 + ...
                    pi * (w + dim*3/8)^2 - pi * (dim*3/8)^2 - 2080^2;
                p_vec = sym2poly(expand(p));
                r = roots(p_vec);
                width = r(2);
                for x = 1:dim
                    for y = 1:dim
                        if (x - dim/2)^2 + (y - dim/2)^2 <= width^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/8)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/8 + width)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/4)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/4 + width)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim*3/8)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim*3/8 + width)^2
                            mask(y, x) = 1;
                        end
                    end
                end
            elseif (j == 2)
                p = pi * (dim/2)^2 - pi * (dim/2 - w)^2 + pi * (dim*3/8)^2 - pi * (dim*3/8 - w)^2 + ...
                    pi * (dim/4)^2 - pi * (dim/4 - w)^2 + pi * (dim/8)^2 - pi * (dim/8 - w)^2 - 2080^2;
                p_vec = sym2poly(expand(p));
                r = roots(p_vec);
                width = r(2);
                for x = 1:dim
                    for y = 1:dim
                        if (x - dim/2)^2 + (y - dim/2)^2 >= (dim/8 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/8)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/4 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/4)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim*3/8 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim*3/8)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/2 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/2)^2
                            mask(y, x) = 1;
                        end
                    end
                end            
            end
        elseif (i == 5)
            if (j == 1)
                p = pi * w^2 + pi * (w + dim/10)^2 - pi * (dim/10)^2 + pi * (w + dim/5)^2 - pi * (dim/5)^2 + ...
                    pi * (w + dim*3/10)^2 - pi * (dim*3/10)^2 + pi * (w + dim*2/5)^2 - pi * (dim*2/5)^2 - 2080^2 ;
                p_vec = sym2poly(expand(p));
                r = roots(p_vec);
                width = r(2);
                for x = 1:dim
                    for y = 1:dim
                        if (x - dim/2)^2 + (y - dim/2)^2 <= width^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/10)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/10 + width)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/5)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/5 + width)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim*3/10)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim*3/10 + width)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim*2/5)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim*2/5 + width)^2
                            mask(y, x) = 1;
                        end
                    end
                end
            elseif (j == 2)
                p = pi * (dim/2)^2 - pi * (dim/2 - w)^2 + pi * (dim*2/5)^2 - pi * (dim*2/5 - w)^2 + ...
                    pi * (dim*3/10)^2 - pi * (dim*3/10 - w)^2 + pi * (dim/5)^2 - pi * (dim/5 - w)^2 + ...
                    pi * (dim/10)^2 - pi * (dim/10 - w)^2 - 2080^2;
                p_vec = sym2poly(expand(p));
                r = roots(p_vec);
                width = r(2);
                for x = 1:dim
                    for y = 1:dim
                        if (x - dim/2)^2 + (y - dim/2)^2 >= (dim/10 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/10)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/5 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/5)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim*3/10 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim*3/10)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim*2/5 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim*2/5)^2 || ...
                                (x - dim/2)^2 + (y - dim/2)^2 >= (dim/2 - width)^2 && (x - dim/2)^2 + (y - dim/2)^2 <= (dim/2)^2
                            mask(y, x) = 1;
                        end
                    end
                end
            end
        end
        
        if j == 1
            config = 'out';
        elseif j == 2
            config = 'in';
        end
        imwrite(mask, ['layouts/ring' num2str(i) config '.PNG']);
    end
end


%% (4) Random Point Selection
% So if we take the quadrant 2080 x 2080 - we want to have some number of
% smaller boxes that will add up to that (should allow range in size here
% size like I don't have to manually make them so it's honestly fine)
% Prime factorization of 2080 = 2^5 * 5 * 13
% NOTE: it could be that after placing a number of boxes, it is impossible
% to place further boxes - in that case this code will hang and keep
% generating random numbers --> just manually stop and restart

% 208 x 208 --> 100 boxes
% 260 x 260 --> 64 boxes
% 416 x 416 --> 25 boxes
% 520 x 520 --> 16 boxes
% 1040 x 1040 --> 4 boxes

options = [208, 260, 416, 520, 1040];
for option_i = 1:5
    for iter = 1:4 % Generate 4 random layouts
        dim_box = options(option_i);
        num_boxes = (dim/2)^2/(dim_box)^2;
        rng('shuffle');
    
        mask = zeros(dim, dim);
        for i = 1:num_boxes
            % Check if anything overlaps, if so redo the rng
            while (true)
                found_overlap = false; % Reset this boolean each time
                x = randi(4161 - dim_box);
                y = randi(4161 - dim_box);
                for j = 0:(dim_box - 1)
                    % Exit outer for-loop too if we found an overlap such that we
                    % generate new random point (x, y)
                    if (found_overlap)
                        break;
                    end
                    for k = 0:(dim_box - 1)
                        if mask(y + k, x + j) == 1
                            found_overlap = true;
                            break; % Exit inner for-loop
                        end
                    end
                end
                % Move on if we successfully found no overlap
                if (~found_overlap)
                    break;
                end
            end
            
            % Fill in everything in the box with this (x, y) as top-left corner
            for j = 0:(dim_box - 1)
                for k = 0:(dim_box - 1)
                    mask(y + k, x + j) = 1;
                end
            end
        end
        imwrite(mask, ['layouts/random' num2str(num_boxes) '_' num2str(iter) '.PNG']);
    end
end


%% (5) Spiral
% I didn't refactor this one to save to folder whatever it's a bit lengthy
% (5a) Archimedean spiral
% Use the polar equation for a spiral (Archimedean spiral)
% I could have plotted things with (0, 0) as the center and translated it
% NOTE: Right now it's the normal positive k graph but reflected
% horizontally down across y = 0 (switching x and y doesn't solve that one)

% We should base it off of (1) the number of turns/length of spiral, (2)
% size of boxes (corresp. to number)??? So based on the number of boxes,
% need to calculate arc length of the entire spiral and then split evenly:
    % Start the first box centered at the center of the spiral
    % End the last box centered at the last 2pi position
    % Centered means like if it was 10 x 10 then (6, 6) is at the center
    % 208, 260, 416, 520 pixels <-> 100, 64, 25, 16 boxes

prompt = '(Spiral) Select the number of turns x...y: ';
num_turns = input(prompt);
while (num_turns ~= 1 && num_turns ~= 2 && num_turns ~= 3 && num_turns ~= 4 && num_turns ~= 5)
    num_turns = input("(Spiral) Invalid selection. Select again: ");
end
prompt = '(Spiral) Select the size of box (208, 260, 416, 520): ';
dim_box = input(prompt);
while (dim_box ~= 208 && dim_box ~= 260 && dim_box ~= 416 && dim_box ~= 520)
    dim_box = input("(Spiral) Invalid selection. Select again: ");
end

num_boxes = (dim/2)^2 / (dim_box^2);

% ex. with 16 boxes and say 4 turns (8pi), first solve for coeff.
% Not symmetrical (total width depends on pi and 2pi position of last turn)
% 4160 = k * (7 * pi) + k * (8 * pi) --> k = 4160 / (15 * pi)
% Add dim_box amount of padding (or rather dim_box + 1 for good measure)
k = (dim - (dim_box + 1)) / ((num_turns * 4 - 1) * pi);
disp(['Coefficient: ' num2str(k)]); % 88.2779

% s = integral from 0 to 8pi of sqrt([f(theta)]^2 + [f'(theta)]^2) dtheta
% The following is slightly simplified
syms x;
fun = @(x) k * sqrt(x.^2 + 1); % Creating function handle
total_arc_length = integral(fun, 0, num_turns * (2 * pi));
disp(['Total arc length: ' num2str(total_arc_length)]); % 28075.5722

% To fit 16 boxes we need to separate it into 15 sections
arc_segment = total_arc_length / (num_boxes - 1); % 1871.7
old_arc_segment = arc_segment;

m_spiral = zeros(dim, dim);
oob = 0;
overlap = 0;
% Skipping the first box to lessen overlap
for i = 1:(num_boxes - 1)
    % Now we need the arc length formula to see where the boxes should be
    % Compute the indefinite integral
    indef_integral = int(sym(k) * sqrt(x.^2 + 1), x);
    % Evaluate: indef_integral(x) - indef_integral(0) = i * arc_segment, solve for x
    x_a = 0;

    % Slight adjustments for OOB at left, but make sure it doesn't change
    % for future i
    arc_segment = old_arc_segment; 
    if (num_turns == 3 && num_boxes == 25 && i == 17)
        arc_segment = arc_segment + 2;
    end

    box_angle = solve(indef_integral - subs(indef_integral, x, x_a) - i * arc_segment, x);

    % The center is at the following (x, y) --> (col, row)
    % These have to be rounded to later be used to calculate indices... (hopefully this is not an issue)
    x_offset = round(k * ((num_turns * 2 - 1) * pi)); % based on pi position, 1941
    y_offset = round(k * ((num_turns * 4 - 1) / 2 * pi)) + 4; % based on 3pi/2 position 2080, padding to avoid OOB

    % Need to convert to double, else it's evaluating as symbolic
    % expression and takes a really long time, add in the padding too
    box_x = double(round((k * box_angle) .* cos(box_angle) + x_offset)) + dim_box / 2;
    box_y = double(round((k * box_angle) .* sin(box_angle) + y_offset)) + dim_box / 2;

    % If out of bounds, don't place this box
    if (box_y - dim_box / 2 <= 0) || (box_x - dim_box / 2 <= 0) || ...
            (box_y + dim_box / 2 + 1 > dim) || (box_x + dim_box / 2 + 1 > dim)
        disp("ABOVE IS OOB");
        oob = oob + 1;
        continue;
    end

    % Need to place 520 / 2 = 260 pixels to the left of it and to the right
    % including it, also above it and below it to the right including it.
    for a = 1:(dim_box / 2)
        for b = 1:(dim_box / 2)
            if m_spiral(box_y - b, box_x - a) == 1
                overlap = overlap + 1;
            end
            if m_spiral(box_y - b, box_x + a - 1) == 1
                overlap = overlap + 1;
            end
            if m_spiral(box_y + b - 1, box_x - a) == 1
                overlap = overlap + 1;
            end
            if m_spiral(box_y + b - 1, box_x + a - 1) == 1
                overlap = overlap + 1;
            end

            m_spiral(box_y - b, box_x - a) = 1;
            m_spiral(box_y - b, box_x + a - 1) = 1;
            m_spiral(box_y + b - 1, box_x - a) = 1;
            m_spiral(box_y + b - 1, box_x + a - 1) = 1;
        end
    end
end

disp(['NUM OOB: ' num2str(oob)]);
disp(['OVERLAP: ' num2str(overlap)]);

figure();
imshow(m_spiral);
title(['Spiral (' num2str(num_turns) ' turns, ' num2str(num_boxes) ' boxes)']);
imwrite(m_spiral, ['layouts/spiral_' num2str(num_turns) 't' num2str(num_boxes) 'b.PNG']);


%% (6) Strip (Transect)
% Vertical strips. Strips of size dim/4, dim/8, then dim/16

for j = 1:3 % 4, 8, or 16 equal slices total
    for k = 1:4 % 4 configurations
        mask = zeros(dim, dim);
        for x = 1:dim
            for y = 1:dim
                if j == 1
                    if (k == 1)
                        if (x < dim/4)
                            mask(y, x) = 1;
                        end
                    elseif (k == 2)
                        if (x >= dim/4 && x < dim/2)
                            mask(y, x)= 1;
                        end
                    elseif (k == 3)
                        if (x >= dim/2 && x < dim*3/4)
                            mask(y, x) = 1;
                        end
                    elseif (k == 4)
                        if (x >= dim*3/4 && x <= dim)
                            mask(y, x) = 1;
                        end
                    end
                elseif j == 2
                    if (k == 1)
                        if (x < dim/8) || (x >= dim/2 && x < dim*5/8)
                            mask(y, x) = 1;
                        end
                    elseif (k == 2)
                        if (x >= dim/8 && x < dim/4) || (x >= dim*5/8 && x < dim*3/4)
                            mask(y, x)= 1;
                        end
                    elseif (k == 3)
                        if (x >= dim/4 && x < dim*3/8) || (x >= dim*3/4 && x < dim*7/8)
                            mask(y, x) = 1;
                        end
                    elseif (k == 4)
                        if (x >= dim*3/8 && x < dim/2) || (x >= dim*7/8 && x <= dim)
                            mask(y, x) = 1;
                        end
                    end
                elseif j == 3
                    if (k == 1)
                        if (x < dim/16) || (x >= dim/4 && x < dim*5/16) || (x >= dim/2 && x < dim*9/16) || (x >= dim*3/4 && x < dim*13/16)
                            mask(y, x) = 1;
                        end
                    elseif (k == 2)
                        if (x >= dim/16 && x < dim/8) || (x >= dim*5/16 && x < dim*3/8) || (x >= dim*9/16 && x < dim*5/8) || (x >= dim*13/16 && x < dim*7/8)
                            mask(y, x)= 1;
                        end
                    elseif (k == 3)
                        if (x >= dim/8 && x < dim*3/16) || (x >= dim*3/8 && x < dim*7/16) || (x >= dim*5/8 && x < dim*11/16) || (x >= dim*7/8 && x < dim*15/16)
                            mask(y, x) = 1;
                        end
                    elseif (k == 4)
                        if (x >= dim*3/16 && x < dim/4) || (x >= dim*7/16 && x <= dim/2) || (x >= dim*11/16 && x < dim*3/4) || (x >= dim*15/16 && x <= dim)
                            mask(y, x) = 1;
                        end
                    end
                end
            end
        end

        num_strips = [1 2 4];
        imwrite(mask, ['layouts/strip' num2str(num_strips(j)) '_' num2str(k) '.PNG']);
    end
end