clc
clear
A3=imread('Target_10.tiff');
%image(A3);
%load wbarb
%A=rgb2gray(A3);
A=A3;
imshow(A);
g=colormap;

%[C,S] = wavedec2(A,3,'bior3.7');
[CA,CH,CV,CD] = dwt2(A,'bior4.4');
[CA1,CH1,CV1,CD1] = dwt2(CA,'bior4.4');
[CA2,CH2,CV2,CD2] = dwt2(CA1,'bior4.4');
%a1 = waverec2(C,S,'bior3.7');

figure(2)
colormap(g);
image(A);
C4 = CA';
c = C4(:);
%l = c'

b = [1:size(c,1)];
d = b';


Z = idwt2(CA1,[],[],[],'bior4.4');
U = idwt2(Z,[],[],[],'bior4.4');


q = c(1:263);
% cost = [1 10 50 100]
% gamma = [0.001 0.003 0.009 0.03 0.09 0.3 0.9]
 error = 0;
% for i=1:size(cost,2)
%     for j=1:size(gamma,2)
%         reg = svr_trainer(d(1:139),((q-mean(q))/sqrt(var(q))),cost(i),0.0000000025,'gaussian',gamma(j));
%         reg1 = reg.predict(d(1:139));   
%         error1 = sum(((q-mean(q))/sqrt(var(q))-reg1).^2)
%         error = [error error1]
%     end  
% end

for i=1:1
q = c((263*(i-1)+1:263*i));
%reg = svr_trainer(d(1:139),((q-mean(q))/sqrt(var(q))),1,0.0000000025,'gaussian',0.5);
reg = svr_trainer(d(1:263),((q-mean(q))/sqrt(var(q))),1,0.005,'gaussian',0.5);
reg1 = reg.predict(d(1:263)); 
reg1 = (reg1*sqrt(var(q)) + mean(q));
plot(reg1,'r');
hold;
plot(q,'b');
end

size(C4)

size(U)

% RMS error

% diff = U - N;
% error = diff.^2;
% mse = sum(error(:))/numel(U)
% rmse = sqrt(mse)



