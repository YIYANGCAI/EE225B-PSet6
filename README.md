# EE225B-PSet6

## Intro
This problem set mainly focus on the image reconstruction based on projection. Briefly speaking, projection is to add all pixel value of an image along one specific direction, obtaining a 1D vector. With several different directions we can obtain a 'feature' array of original image. One typical method related to this is Radon transformation. Another useful method is Fourier Slice Theorem: the projection's FT equals to FT's projection, and the angles are the same.

## Run the code
There are two sub-problems, the first is to study the radon and iradon functions, the other one is to implement interploration and FFT to radon transformation to reconstruct the image. Code of p1 is in Problem1.m, code of p2 is in Problem2.m 
```
Problem1
```
It will output ConvBack.bmp, ConvBack2.bmp, ConvBack5.bmp

```
Problem2
```
It will output Polar.bmp
