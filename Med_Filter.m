function [ NoiseImg2 ] = Med_Filter(image)
NoiseImg2=medfilt2(real(image));
NoiseImg2=double(NoiseImg2);
end