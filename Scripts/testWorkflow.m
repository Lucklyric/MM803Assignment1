clear all;
close all;
origionalFilename = '5.png';
groundThruthFileName = '5_gt_gray.png';
I = rgb2hsv(imread(origionalFilename));
map = [1 1 1; 0.8 .2 .2;0  0 1;0,1,0];
Gt = (imread(groundThruthFileName));
h = size(I,1);
w = size(I,2);
%smooth the image by coherence filter:
m3filted_I = CoherenceFilter(rgb2gray(hsv2rgb((I))),struct('T',5,'rho',2,'Scheme','I', 'sigma', 1));
%m3filted_I = CoherenceFilter(rgb2gray(lab2rgb(I)),struct('T',5,'rho',2,'Scheme','I', 'sigma', 1));
%adjacent neighborhood  model:
m3L = graphSeg(m3filted_I, 0.5, 3, 8, 0);
figure(1);
subplottight(2,3,1),imshow(imread(origionalFilename)),title('Original');
subplottight(2,3,2),imshow(imread(groundThruthFileName)),title('GroundTruth');
subplottight(2,3,3),graythreshMethod,title('Threshold Method');
subplottight(2,3,4),kmeansMethod,title('K-means Method');
%subplottight(2,3,5),graphbasedMethod,title('Efficient graph-based Method');
%subplottight(2,3,6),randomWalkerMethod,title('Random walks Method');

%kmeansMethod;
%graphbasedMethod;