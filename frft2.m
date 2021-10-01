function [out] = frft2(matrix,angles)
%
% computes 2-D FRFT of given matrix with given angles
%
% IN : matrix: matrix to be transformed
%      angles : angles of FrFT in x and y direction

temp = matrix.';

%%%%%%%%%% first for x-direction
N = size(matrix,1); a = angles(1);
shft = rem((0:N-1)+fix(N/2),N)+1;
sN = sqrt(N);
a = mod(a,4);
% do special cases first
if      (a==0) % do nothing;
elseif  (a==2) temp = flipud(temp);
elseif  (a==1) temp(shft,:) = fft(temp(shft,:))/sN;
elseif  (a==3) temp(shft,:) = ifft(temp(shft,:))*sN;
else  % reduce to interval 0.5 < a < 1.5
 if     (a > 2.0) a = a-2; temp = flipud(temp);
 elseif (a > 1.5) a = a-1; temp(shft,:) = fft(temp(shft,:))/sN;
 elseif (a < 0.5) a = a+1; temp(shft,:) = ifft(temp(shft,:))*sN;
 end
 % precompute some parameters
 alpha=a*pi/2;
 s = pi/(N+1)/sin(alpha)/4;
 t = pi/(N+1)*tan(alpha/2)/4;
 Cs = sqrt(s/pi)*exp(-1i*(1-a)*pi/4);
 snc = sinc([-(2*N-3):2:(2*N-3)]'/2);
 chrp = exp(-1i*t*(-N+1:N-1)'.^2);
 chrp2 = exp(1i*s*[-(2*N-1):(2*N-1)]'.^2);
 % now transform each column
 for ix = 1:N,
  f0 = temp(:,ix);
  % sinc interpolation
  f1 = fconv(f0,snc,1);
  f1 = f1(N:2*N-2);

  % chirp multiplication
  l0 = chrp(1:2:end); l1=chrp(2:2:end);
  f0 = f0.*l0;        f1=f1.*l1;

  % chirp convolution
  e1 = chrp2(1:2:end);  e0 = chrp2(2:2:end);
  f0 = fconv(f0,e0,0); f1 = fconv(f1,e1,0);
  h0 = ifft(f0+f1);

  temp(:,ix) = Cs*l0.*h0(N:2*N-1);
 end % for
end % else
temp = temp.';

%%%%%%%%%%%%% now for y-direction

N = size(matrix,2); a = angles(2);
shft = rem((0:N-1)+fix(N/2),N)+1;
sN = sqrt(N);
a = mod(a,4);

if      (a==0) ; % do nothing
elseif  (a==2) temp = flipud(temp);
elseif  (a==1) temp(shft,:) = fft(temp(shft,:))/sN;
elseif  (a==3) temp(shft,:) = ifft(temp(shft,:))*sN;
else
 % reduce to interval 0.5 < a < 1.5
 if     (a>2.0) a = a-2; temp = flipud(temp);
 elseif (a>1.5) a = a-1; temp(shft,:) = fft(temp(shft,:))/sN;
 elseif (a<0.5) a = a+1; temp(shft,:) = ifft(temp(shft,:))*sN;
 end;

 % precompute some parameters
 alpha=a*pi/2;
 s = pi/(N+1)/sin(alpha)/4;
 t = pi/(N+1)*tan(alpha/2)/4;
 Cs = sqrt(s/pi)*exp(-1i*(1-a)*pi/4);
 snc = sinc([-(2*N-3):2:(2*N-3)]'/2);
 chrp = exp(-1i*t*(-N+1:N-1)'.^2);
 chrp2 = exp(1i*s*[-(2*N-1):(2*N-1)]'.^2);
 
 % now transform each column
 for ix = 1:N,
  f0 = temp(:,ix);
  % sinc interpolation
  f1 = fconv(f0,snc,1);
  f1 = f1(N:2*N-2);

  % chirp multiplication
  l0 = chrp(1:2:end); l1=chrp(2:2:end);
  f0 = f0.*l0;        f1=f1.*l1;

  % chirp convolution
  e1 = chrp2(1:2:end);  e0 = chrp2(2:2:end);
  f0 = fconv(f0,e0,0); f1 = fconv(f1,e1,0);
  h0 = ifft(f0+f1);

  temp(:,ix) = Cs*l0.*h0(N:2*N-1);
 end % for
end % else
out = temp;
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z = fconv(x,y,c)
% convolution by fft

N = length([x(:);y(:)])-1;
P = 2^nextpow2(N);
z = fft(x,P) .* fft(y,P);
if c ~= 0,
   z = ifft(z);
   z = z(1:N);
end

