clc; clear all;
img=imread('peppers.png');
figure(1),imshow(img);


img1=img(:,:,1);
[m, n]=size(img1);
figure(2),imshow(img1);
img2=img(:,:,2);
figure(3),imshow(img2);
img3=img(:,:,3);
figure(4),imshow(img3);

%to get elements along rows 
temp1=reshape(img1',m*n,1);
%figure(5),imshow(temp1);
temp2=reshape(img2',m*n,1);
%figure(6),imshow(temp2);
temp3=reshape(img3',m*n,1);
%figure(7),imshow(temp3);

I=[temp1 temp2 temp3]; 
%figure(8),imshow(I);

%to get mean
m1=mean(I,2);
%figure(9),imshow(m1);

%subtract mean
%temp=double(I);
for i=1:3
    I1(:,i)=(double(I(:,i))-m1);
end
a1=double(I1);
%figure(10),imshow(I1);

a=a1';
covv =1/(m-1)*(a*a');

[eigenvec, eigenvalue]=eig(covv);

%abhi=eigenvalue;
eigenvalue1 = diag(eigenvalue);
[egn,index]=sort(-1*eigenvalue1);
eigenvalue1=eigenvalue1(index);
eigenvec1=eigenvec(:,index);
%figure(11),imshow(eigenvec);
%pcaoutput=a1*eigenvalue;


pcaoutput=a1*eigenvec1;
%figure(12),imshow(pcaoutput);



%disp(size(pcaoutput,2));


for i=1:size(pcaoutput,2)
    ima=reshape(pcaoutput(:,i)',m,n);
    ima=ima';
   
     figure(i+13),imshow(ima,[]);
end


%Inverse PCA

V_inv=inv(eigenvec1);
original=pcaoutput*V_inv;
for i=1:3
    I2(:,i)=(double(original(:,i))+m1);
end
I2=round(I2);
img6=reshape(I2(:,1)',m,n);
img6=img6';
img7=reshape(I2(:,2)',m,n);
img7=img7';
img8=reshape(I2(:,3)',m,n);
img8=img8';
back_to_original_img = cat(3, img6, img7, img8);
figure(20), imshow(uint8(back_to_original_img)); title('Original Back');


