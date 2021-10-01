
function [ NoiseImg2 ] = SaltPepper(image)
NoiseImg2 = imnoise(uint8(image),'salt & pepper',0.02);
NoiseImg2=double(NoiseImg2);
end