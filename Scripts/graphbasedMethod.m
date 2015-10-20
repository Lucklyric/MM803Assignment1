
%k-nearest neighborhood model:
%Lnn = graphSeg(filted_I, 0.5/sqrt(3), 50, 10, 1);
%display:
%level = graythresh(L);
%Rgb = label2rgb(L);
%out = im2bw(rgb2gray(Rgb));
%imshow(label2rgb(m3L));
%apply K-means here
m3Gray = (rgb2gray(label2rgb(m3L)));
m3X = m3Gray(:);
m3ind = kmeans(double(m3X),3);
%m3ind(m3ind==1) = 0;
%m3ind(m3ind~=0) = 1;
m3J = reshape(m3ind,[h w]);
imshow(label2rgb(m3J,map,[0,0,0]));
fprintf('graphbased:%f\n',jaccard_coefficient(logical(Gt~=0),logical(m3J~=1)));
%subplot(3, 1, 3), imshow(label2rgb(Lnn)), title('k nearest neighborhood based segmentation');