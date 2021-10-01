x = [5 10 15 20 40];
y = [50 45 40 35 35];
display('The Initial Data Sets X and Y');
display(x);
display(y);

x_bar=mean(x);
y_bar=mean(y);

display('The Mean Values are');
display(x_bar);
display(y_bar);

display('The Normalized Values are');
x_norm=x-x_bar;
y_norm=y-y_bar;

display(x_norm);
display(y_norm);

display('The Covariance Matrix is');
COV=cov(x,y);
display(COV);

display('The Eigen Values of the Covariance Matrix are');
EIG=eig(COV);
display(EIG);



display('The Eigen Vectors of the Covariance Matrix are');
[V,D]=eig(COV);
display(V);


display('The new Data Set after PCA is');
V_Trans=V';
display(V_Trans);

temp=[x_norm;y_norm];
display(temp);

Output=V_Trans*temp;
display(Output);


V_inv=inv(V_Trans);
display('The inverse of the Transposed Vector Matrix is');
display(V_inv);

X_org=V_inv*Output;
X_org(1,:)=X_org(1,:)+x_bar;
X_org(2,:)=X_org(2,:)+y_bar;
display('The original Data Set again is');
display(X_org);










