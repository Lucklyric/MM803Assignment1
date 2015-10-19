clear all;
origionalFilename = '1.png';
groundThruthFileName = '1_gt_gray.png';
img=im2double(imread(origionalFilename));
figure
imshow(img);
[X Y] = size(img);
[s1x,s1y] = ginput(1);
[s2x,s2y] = ginput(1);
fprintf('s1x:%f\n',s1x);