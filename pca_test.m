Host_image1=imread('peppers.png');
Host_image=imresize(Host_image1,0.2);

figure(1),imshow(uint8(Host_image));title('Original RGB Image');

red = Host_image(:,:,1); % Red channel
green = Host_image(:,:,2); % Green channel
blue = Host_image(:,:,3); % Blue channel

figure(2),imshow(uint8(red));title('Red Part');
figure(3),imshow(uint8(green));title('Green Part');
figure(4),imshow(uint8(blue));title('Blue Part');

a = zeros(size(Host_image, 1), size(Host_image, 2));
just_red = cat(3, red, a, a);
just_green = cat(3, a, green, a);
just_blue = cat(3, a, a, blue);

back_to_original_img = cat(3, red, green, blue);

figure(5), imshow(just_red), title('Red channel');
figure(6), imshow(just_green), title('Green channel');
figure(7), imshow(just_blue), title('Blue channel');
figure(8), imshow(back_to_original_img), title('Original Back');



