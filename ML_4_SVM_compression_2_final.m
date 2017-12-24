clc
clear
A=imread('Target_4.tiff');
%A = imread('airplane.png');
%image(A3);
%load wbarb
%A=rgb2gray(A3);
imshow(A);
g=colormap;

figure(2)
colormap(g);
image(A);

c = A(:);
%l = c'

b = [1:size(c)];
d = b';

sup_vec = 0;

reg2 = zeros(size(A,1),1);
for i = 1:size(A,1)
    q = zeros(size(A,2),1);
    %reg2 = zeros(size(CA1,1),1);
    reg1 = zeros(size(A,1),1);
    C4 = A(i,:);
    q = C4(:);
    q = double(q);
    reg = svr_trainer_1(d,((q-mean(q))/sqrt(var(q))),1,0.0000000025,'gaussian',0.5);
    %reg = svr_trainer([1:134]',q,1,0.0000000025,'gaussian',0.5);
    %sup_vec = sup_vec + size(find((reg.alpha==1) | ((reg.alpha>0) & (reg.alpha<=0.7)) | (reg.alpha)<=0));
    sup_vec = sup_vec + size(find(reg.alpha~=0),1);
    reg1 = reg.predict(d);    
    %reg2 = [reg2 reg1];
    reg2 = [reg2 (reg1*sqrt(var(q)) + mean(q))];
    % reg1 = (reg.p1)*d.^2 + (reg.p2)*d + (reg.p3);
% plot(reg1)
    i
end
 
figure(8)
colormap(g);
image(reg2(1:512,1:512));

%%

clc
clear
A=imread('Target_10.tiff');
%A = imread('airplane.png');
%image(A3);
%load wbarb
%A=rgb2gray(A3);
imshow(A);
g=colormap;

%[C,S] = wavedec2(A,3,'bior3.7');
[CA,CH,CV,CD] = dwt2(A,'bior3.7');
%[CA1,CH1,CV1,CD1] = dwt2(CA,'bior3.7');
%[CA2,CH2,CV2,CD2] = dwt2(CA1,'bior3.7');
%a1 = waverec2(C,S,'bior3.7');
%[CA3,CH2,CV2,CD2] = dwt2(CA2,'bior3.7');
%image(CA2);
%image(a1);

figure(2)
colormap(g);
image(A);
C4 = CA(1,:);
c = C4(:);
%l = c'

b = [1:size(c)];
d = b';

% Z = idwt2(CA2,[],CD2,[],'bior3.7');
% V = idwt2(Z,[],[],[],'bior3.7');
% U = idwt2(V,[],[],[],'bior3.7');

U = idwt2(CA,[],[],[],'bior3.7');
%U = idwt2(Z,[],[],[],'bior3.7');

%mdl = LinearModel.fit(d,c)
%plot(mdl)

% reg = svr_trainer(d,c,400,0.000000025,'gaussian',500);
 figure(3)
 colormap(g);
image(U);
% 
 %figure(4)
% q = reg.predict;
% plot(q);

% run(reg.predict);

%disp(reg);
%l = 0.1;

sup_vec = 0;
i = 1;
reg2 = zeros(size(CA,1),1);
while i <= size(CA,1)
    q = zeros(size(CA,2),1);
    %reg2 = zeros(size(CA1,1),1);
    reg1 = zeros(size(CA,1),1);
    C4 = CA(i,:);
    q = C4(:);
    %q = uint8(q);
    reg = svr_trainer_1(d,((q-mean(q))/sqrt(var(q))),1,0.0000000025,'gaussian',0.5);
    %reg = svr_trainer([1:134]',q,1,0.0000000025,'gaussian',0.5);
    %sup_vec = sup_vec + size(find((reg.alpha==1) | ((reg.alpha>0) & (reg.alpha<=0.7)) | (reg.alpha)<=0));
    sup_vec = sup_vec + size(find(reg.alpha~=0),1);
    reg1 = reg.predict(d);    
    %reg2 = [reg2 reg1];
    reg2 = [reg2 (reg1*sqrt(var(q)) + mean(q))];
    % reg1 = (reg.p1)*d.^2 + (reg.p2)*d + (reg.p3);
% plot(reg1)
    i
    i = i+1;
 end

% reg = svr_trainer_1(d,CA1(:)',1000,0,'gaussian',0.5);
% reg1 = reg.predict(d);   
% 
% reg2 = reshape(reg1,139,139);
T = reg2(:,2:end);
M = idwt2(T',[],[],[],'bior3.7');
%M = idwt2(reg2,[],[],[],'bior3.7');
%N = idwt2(M',[],[],[],'bior3.7');

%N = histeq(N);
% N = uint8(N);
% N = histeq(N);
% A = histeq(A);
figure(8)
colormap(g);
image(M);

size(C4)

size(U)
%Q = M(1:size(A,1),3:end);
% RMS error
%A = double(A);
%Q = N(3:end,3:end);
A = double(A);
mse = sum((A(:)-M(:)).^2) /prod(size(A));

psnr = 10*log10(255*255/mse);

M = uint8(M);

folder = 'E:\SVM_Image_Compression\Target_9\negetive_alpha'
imwrite(M,fullfile(folder,'alpha_lessthan_equalto_-04.jpg'));






