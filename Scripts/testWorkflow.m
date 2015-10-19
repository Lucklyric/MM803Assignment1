clear all;
close all;
origionalFilename = '1.png';
groundThruthFileName = '1_gt_gray.png';
I = imread(origionalFilename);
Gt = im2bw(imread(groundThruthFileName));
h = size(I,1);
w = size(I,2);

figure;
subplottight(2,3,1),imshow(I);
subplottight(2,3,2),imshow(Gt);
subplottight(2,3,3),graythreshMethod;
subplottight(2,3,4),kmeansMethod;
subplottight(2,3,5),;
subplottight(2,3,6),imshow(I);

%kmeansMethod;
%graphbasedMethod;