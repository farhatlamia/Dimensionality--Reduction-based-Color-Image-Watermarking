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
I_11=[temp1 temp2];
I_22=[temp2 temp3];
I_33=[temp1 temp3];


%to get mean
m1=mean(I,2);
m_11=mean(I_11,2);
m_22=mean(I_22,2);
m_33=mean(I_33,2);


%figure(9),imshow(m1);

%subtract mean
%temp=double(I);
for i=1:3
    I1(:,i)=(double(I(:,i))-m_11);
    I2(:,i)=(double(I(:,i))-m_22);
    I3(:,i)=(double(I(:,i))-m_33);
    
end
a1=double(I1);
a2=double(I2);
a3=double(I3);

%figure(10),imshow(I1);

a=a1';
b=a2';
c=a3';

covv1 =1/(m-1)*(a*a');
covv2 =1/(m-1)*(b*b');
covv3 =1/(m-1)*(c*c');

[eigenvec1, eigenvalue1]=eig(covv1);
[eigenvec2, eigenvalue2]=eig(covv2);
[eigenvec3, eigenvalue3]=eig(covv3);


eigenvalue_11 = diag(eigenvalue1);
[egn1,index1]=sort(-1*eigenvalue_11);
eigenvalue_11=eigenvalue_11(index1);
eigenvec_11=eigenvec1(:,index1);
pcaoutput1=a1*eigenvec_11;


eigenvalue_22 = diag(eigenvalue2);
[egn2,index2]=sort(-1*eigenvalue_22);
eigenvalue_22=eigenvalue_22(index2);
eigenvec_22=eigenvec2(:,index2);
pcaoutput2=a2*eigenvec_22;

eigenvalue_33 = diag(eigenvalue3);
[egn3,index3]=sort(-1*eigenvalue_33);
eigenvalue_33=eigenvalue_33(index3);
eigenvec_33=eigenvec3(:,index3);
pcaoutput3=a3*eigenvec_33;



%disp(size(pcaoutput,2));


for i=1:size(pcaoutput1,2)
    ima1=reshape(pcaoutput1(:,i)',m,n);
    ima1=ima1';
    figure(i+13),imshow(ima1,[]);
    
    ima2=reshape(pcaoutput2(:,i)',m,n);
    ima2=ima2';
    figure(i+23),imshow(ima2,[]);
    
    ima3=reshape(pcaoutput3(:,i)',m,n);
    ima3=ima3';
    figure(i+33),imshow(ima3,[]);
end


%Inverse PCA

V_inv1=inv(eigenvec_11);
V_inv2=inv(eigenvec_22);
V_inv3=inv(eigenvec_33);

original1=pcaoutput1*V_inv1;
original2=pcaoutput2*V_inv2;
original3=pcaoutput3*V_inv3;


for i=1:3
    Org1(:,i)=(double(original1(:,i))+m_11);
    Org2(:,i)=(double(original2(:,i))+m_22);
    Org3(:,i)=(double(original3(:,i))+m_33);
end

Org1=round(Org1);
img6=reshape(Org1(:,1)',m,n);
img6=img6';
img7=reshape(Org1(:,2)',m,n);
img7=img7';
img8=reshape(Org1(:,3)',m,n);
img8=img8';
back_to_original_img = cat(3, img6, img7, img8);
figure(20), imshow(uint8(back_to_original_img)); title('Original Back');


