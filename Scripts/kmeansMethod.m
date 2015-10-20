%Gt = im2bw(imread(groundThruthFileName));
% read a color image
%I = imread(origionalFilename);
% show the image
%figure(1),imagesc(I),axis image;
% height and width of the image
h = size(I,1);
w = size(I,2);

% take R, G, B matrices separately
x1 = I(:,:,1);
x2 = I(:,:,2);
x3 = I(:,:,3);

% put these matrices as column vectors side by side to form a matrix X
m2X = [x1(:) x2(:) x3(:)];

% call k-means clustering 
m2ind = kmeans(double(m2X),4);

% because ind is a column vector, reshape it to form an image
m2J = reshape(m2ind,[h w]);

imshow(label2rgb(m2J,map,[0,0,0])),axis image;

fprintf('k-mean:%f\n',jaccard_coefficient(logical(Gt~=0),logical(m2J==4)));

%figure(3),scatter3(X(ind==1,1),X(ind==1,2),X(ind==1,3),'w.');
%figure(3),hold on; scatter3(X(ind==2,1),X(ind==2,2),X(ind==2,3),'w.');
%figure(3),hold on; scatter3(X(ind==3,1),X(ind==3,2),X(ind==3,3),'b.');