function [ NoiseImg2 ] = Avg_Filter(image)
NoiseImg2=conv2(image,(ones(3,3)./9),'same');
% NoiseImg2=double(NoiseImg2);
end