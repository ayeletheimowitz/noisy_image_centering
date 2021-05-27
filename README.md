# Centering Noisy Images

This is the GPU-compatible version. If you do not have a GPU, check out the [original version](https://github.com/nirsharon/RACER) of our project.

This package contains an implementation of our method for estimating the center of mass as described in the paper:

A. Heimowitz, N. Sharon and A. Singer, "Centering Noisy Images with Application to Cryo-EM". [https://arxiv.org/pdf/2009.04810.pdf](https://arxiv.org/pdf/2009.04810.pdf). To appear in SIAM Journal on Imaging Sciences.

To get started, run the following commands in MATLAB

`setup;`

`[PSWF, weight_vec] = Preprocess(L); % L is an upper bound on the radius of the object to be centered`

`[shift, centered_img, Initial_grid_values] = CenterPyramid(sp_img, PSWF, weight_vec); % sp_img is the image containing the object to be centered`

The implementation requires the Distributed Computing Toolbox to be installed. 

The Prolate generation code was contributed by [Boris Landa](https://math.yale.edu/people/boris-landa). 

Legendre-Gauss Quadrature Weights and Nodes were computed using code by Greg von Winckel (2021): [Legendre-Gauss Quadrature Weights and Nodes](https://www.mathworks.com/matlabcentral/fileexchange/4540-legendre-gauss-quadrature-weights-and-nodes), available at MATLAB Central File Exchange. 

[Jacobi polynomials](https://github.com/ayeletheimowitz/noisy_image_centering/blob/master/Prolates%20generating%20code/j_polynomial.m) are evaluated using code by John Burkardt and distributed under the GNU LGPL license.
