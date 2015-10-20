%clear all;
%close all;
% origionalFilename = '1.png';
% groundThruthFileName = '1_gt_gray.png';
img=((imread(origionalFilename)));
figure(2)
imshow(img);
h = size(img,1);
w = size(img,2);
finalImg = zeros(h,w);
for k = 1: 2;
    fprintf('%d choose\n',k);
    majorMask = zeros(h,w);
if k == 2
    inputN = 15;
else
    inputN = 15;
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
%Set two seeds
%s1x=114; s1y=108; %Note that seed location is not central to object
%s2x=152; s2y=76; 

%Apply the random walker algorithms
%[mask,probabilities] = random_walker(img,[sub2ind([w h],s1x,s1y), ...
%    sub2ind([w h],s2x,s2y)],[1,2]);
%figure
figure(1)
imshow(label2rgb(finalImg,map,[0,0,0]));
mark1 = jaccard_coefficient(logical(Gt==0),logical(finalImg==0));
mark2 = jaccard_coefficient(logical(Gt==128),logical(finalImg==1));
mark3 = jaccard_coefficient(logical(Gt==255),logical(finalImg==2));
grade = (mark1+mark2+mark3)/2;
fprintf('randomWlakerMethod:%f\n',jaccard_coefficient(logical(Gt~=0),logical(majorMask~=0)));
% axis equal
% axis tight
% axis off
% hold on
% plot(seedX(:),seedY(:),'g.','MarkerSize',6);
% plot(seedX(1),seedY(1),'b.','MarkerSize',6);
% title('Output mask');