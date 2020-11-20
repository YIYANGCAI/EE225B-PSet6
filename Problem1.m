% read in the image
img = imread('Pyramid.bmp');
figure;imshow(img);
%imwrite(img, 'tmp.bmp');
%grayImage=rgb2gray(srcImage);

% the radon algorithm, basic
R = radon(img,0:179);
I1 = iradon(R,0:179);
%disp(I1);
% no filter is added
I2 = iradon(R,0:179,'linear','none');
figure;imshow(I1,[]);
figure;imshow(I2,[]);
imwrite(I1/255, 'ConvBack.bmp');
%imwrite(I2/255, 'ConvBack_nofilter.bmp');

% reduce the sample by 2
R = radon(img,0:2:179);
I3 = iradon(R,0:2:179);
I4 = iradon(R,0:2:179,'linear','none');
figure;imshow(I3,[]);
figure;imshow(I4,[]);
imwrite(I3/255, 'ConvBack2.bmp');

% reduce the sample by 5
R = radon(img,0:5:179);
I5 = iradon(R,0:5:179);
I6 = iradon(R,0:5:179,'linear','none');
figure;imshow(I5,[]);
figure;imshow(I6,[]);
imwrite(I5/255, 'ConvBack5.bmp');
