function [shift, centeredImg, Initial_grid_values] = CenterPyramid(sp_img, pre_PSWFs, weight_vec)
% 
% The main file for the centering scheme --> no FAST pyramid
%
% Input 
% sp_img        -- Single particle image, that is, the frame where the particle is
%
% Output
% shift        -- the shift from the current center
% centeredImg  -- the estimated centered particle
% Initial_grid_values -- the values of centers on the initial grid for
% statistical evaluation in case of outliers
%
% July, 2020

gpu_exist = gpuDeviceCount;

if gpu_exist
    sp_img = gpuArray(sp_img);
end

% support_size -- the size of the particle frame (diameter)
L = pre_PSWFs.L;
support_size = pre_PSWFs.L*2+1;

% assert input
assert(nargin>=1,'Not enough input parameters');
assert(nargin>=2,'Run Preprocessing.m');
assert(isnumeric(support_size),'Input of support size is not a numeric type')
assert(numel(support_size)==1,'Input of support size must be scalar')
assert(support_size==abs(round(support_size)),'Input support size must be a positive integer')

% verify image is square
sp_img = sp_img(1:min(size(sp_img,1), size(sp_img, 2)), 1:min(size(sp_img,1), size(sp_img, 2)));
assert(2*L<size(sp_img,1), 'Input image is smaller than the diameter of the particle.');

% make sure the pixel intensity is positive
sp_img = sp_img - min(sp_img(:));

% initial grid size (how many center searches are in the first level)
initial_grid_size = floor((size(sp_img,1)-2*L)/2); %min(21, size(sp_img,1)-2*L);

% prepare initial grid 
centerGrid        = zeros(size(sp_img));
centerGrid(L+1:end-L, L+1:end-L) = 1;
current_shift = 1;

% run initial search
[current_center, grid_values] = GridCenterSearch(sp_img, support_size, centerGrid, pre_PSWFs, weight_vec);
Initial_grid_values = grid_values;

% summary
[n1, n2] = size(sp_img);
shift    = current_center - [floor(n1/2)+1,floor(n2/2)+1];
rangeX   = (current_center(1) - L):(current_center(1) + L);
rangeY   = (current_center(2) - L):(current_center(2) + L);
centeredImg = gather(sp_img(rangeX,rangeY));
end



