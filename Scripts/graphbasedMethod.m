%smooth the image by coherence filter:
%m3filted_I = CoherenceFilter(rgb2gray(I),struct('T',5,'rho',2,'Scheme','I', 'sigma', 1));
%adjacent neighborhood  model:
%m3L = graphSeg(m3filted_I, 0.5, 3, 8, 0);
%k-nearest neighborhood model:
%Lnn = graphSeg(filted_I, 0.5/sqrt(3), 50, 10, 1);
%display:
%level = graythresh(L);
%Rgb = label2rgb(L);
%out = im2bw(rgb2gray(Rgb));

%apply K-means here
m3Gray = (rgb2gray(label2rgb(m3L)));
m3X = m3Gray(:);
m3ind = kmeans(double(X),3);
m3ind(m3ind==1) = 0;
m3ind(m3ind~=0) = 1;
m3J = reshape(m3ind,[h w]);
imshow(m3J);
fprintf('graphbased:%f\n',jaccard_coefficient(Gt,logical(m3J)));
%subplot(3, 1, 3), imshow(label2rgb(Lnn)), title('k nearest neighborhood based segmentation');