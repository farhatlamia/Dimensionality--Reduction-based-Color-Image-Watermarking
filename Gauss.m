function [ NoiseImg2 ] = Gauss( image )
  NoiseImg2 = imnoise(uint8(image),'gaussian',0,0.05);
  NoiseImg2=double(NoiseImg2);
 end