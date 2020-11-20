% set some parameters
% I choose one side of the image for test
p_N = 256;
% default sample parameter theta
theta_N = 180;
% fft2D requires a 2-based size
pad_N = 1024;

img = imread('Pyramid.bmp');
theta = 0:(theta_N-1);
% first obtain the radon transformation map
[R,x] = radon(img,theta);

% According to the project's calculate the 1D fft
proj_sino = R;
if mod(length(proj_sino(:,1)),2)==1                       
   proj_sino = [proj_sino;zeros(1,size(proj_sino,2))];    
end
%disp(proj_sino)
pad_row = (pad_N-size(proj_sino,1))/2;
proj_sino = padarray( proj_sino,[pad_row 0],0,'both');
L_pad = pad_row + ceil(((p_N.*sqrt(2)+2)-p_N)/2)+1;

proj_sino = ifftshift(proj_sino,1); 
f_p = fft(proj_sino,[ ],1);            
f_p = fftshift(f_p,1);          

% mesh
nfp = length(f_p(:,1));
omega_sino = (-(nfp-1)/2:(nfp-1)/2).*(2*pi/size(f_p,1));  % p-theta coordinates, seperate 2*pi into 1024 parts
theta = theta*pi/180;                                    
[theta_grid, omega_grid] = meshgrid(theta,omega_sino);    

omega_image = omega_sino;                                               
[omega_grid_x, omega_grid_y] = meshgrid(omega_image, omega_image);     
[coo_th_fft2, coo_r_fft2] = cart2pol(omega_grid_x,omega_grid_y);           
coo_r_fft2 = coo_r_fft2.*sign(coo_th_fft2);                             
coo_th_fft2(coo_th_fft2<0) = coo_th_fft2(coo_th_fft2<0) + pi;           

% interploation
Fourier2_radial = interp2(theta_grid,omega_grid,f_p,coo_th_fft2,coo_r_fft2,'nearest',(0+1i.*0));

% ifft process
crop = L_pad;
% after 2d ifft, obtain another 1024*1024 matrix
% visualize
target = fftshift(ifft2(ifftshift(Fourier2_radial)));                   
target = target(crop+1:end-crop,crop+1:end-crop);              
I_a = abs(target);                                                    
I_a = (I_a-min(I_a(:)))./(max(I_a(:))-min(I_a(:)));                     
Lg_I_a = flipud(log(1+I_a));                                                    

imwrite(Lg_I_a, 'Polar.bmp');

