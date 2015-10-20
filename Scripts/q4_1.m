clear
close all
% [FileName,PathName] = uigetfile('*.*','Select a Image file');
% File = fullfile('Images',FileName); 
% [pathstr,name,ext] = fileparts(FileName); %split filename
img = (imread('3_.png')); %read image
GT_file = strcat('3_gt_gray.png'); %get the path of ground truth image
GT = imread(GT_file);%read ground truth image
figure(2)
imshow(img);
h = size(img,1);
w = size(img,2);
finalImg = zeros(h,w);
for k = 1: 2;
    fprintf('%d choose\n',k);
    majorMask = zeros(h,w);
if k == 2
    inputN = 10;
else
    inputN = 10;
end
[seedX,seedY] = ginput(inputN);
m3Seeds = zeros(length(seedX),1);
m3LabelVector = ones(inputN,1);
m3LabelVector(1) = 0;
m3Seeds(1) = sub2ind([h w],seedY(1),seedX(1));
for i=2:length(seedX)
    m3Seeds(i) = sub2ind([h w],seedY(i),seedX(i));
    try
        [mask,probabilities] = random_walker(img,[m3Seeds(i),m3Seeds(1)],[m3LabelVector(i),0]);
        majorMask = majorMask | (mask);
    catch exception
       fprintf('Cath error\n');
       continue
    end
end
finalImg(majorMask==1) = k;
end
figure(4),imshow(label2rgb(finalImg));
L=label2rgb(finalImg);
redChannel=L(:,:,1); %get red channel
greenChannel=L(:,:,2); %get green channel
blueChannel=L(:,:,3); %get blue channel
R_thresh_level=graythresh(redChannel); 
G_thresh_level=graythresh(greenChannel);
B_thresh_level=graythresh(blueChannel);
BW_r = im2bw(redChannel,R_thresh_level); %create binary image FOR RED
BW_g = im2bw(greenChannel,G_thresh_level); %create binary image FOR GREEN
BW_b = im2bw(blueChannel,B_thresh_level); %create binary image FOR BLUE
label1=BW_r;
label2=BW_g;
label3=BW_b;
BW=label1+label2+label3;
%imshowpair(L, GT, 'montage');% binary image and ground truth image
img_log=BW;
GT_log=GT;
img_log(BW~=1)=0;
GT_log(GT~=128)=0;
score1 = jaccard_coefficient(logical(img_log),logical(GT_log));
img_log=BW;
GT_log=GT;
img_log(BW~=2)=0;
GT_log(GT~=255)=0;
score2 = jaccard_coefficient(logical(img_log),logical(GT_log));
img_log=BW;
GT_log=GT;
img_log(BW==0)=1;
img_log(BW~=0)=0;
GT_log(GT==0)=1;
GT_log(GT~=0)=0;
score3 = jaccard_coefficient(logical(img_log),logical(GT_log));
score = (score1+score2+score3)/3;
