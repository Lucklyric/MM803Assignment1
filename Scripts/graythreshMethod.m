% clear all;
% close all;
% origionalFilename = '4.png';
% groundThruthFileName = '4_gt_gray.png';

R = I(:,:,1);G=I(:,:,2); B=I(:,:,3);
LevelR = graythresh(R); LevelG = graythresh(G); LevelB = graythresh(B);

Mix = double(R) + double(G) + double(B);
MixLevel = graythresh(Mix);
%MixOut = im2bw(I,MixLevel);
Br = im2bw(R,MixLevel); Bg = im2bw(G,MixLevel);Bb = im2bw(B,MixLevel);
% MixAdd = Br+Bg+Bb;
% MixAdd(MixAdd == 2) = 1;
% MixAdd(MixAdd == 3) = 2;
[X,Y] = size(Br);
mix = zeros(X,Y);
for i=1:X
    for j=1:Y
        if Br(i,j) == 1 || Bg(i,j) == 1
             if Bb(i,j) == 0
                 if Br(i,j) == Bg(i,j)
                    mix(i,j) = 1;
                 else
                    mix(i,j) = 2;
                 end
             end
        end
    end
end
map = [1 1 1; .4 .4 .4; 1 0 0];
imshow(label2rgb(mix,map,[0,0,0]));
mix(mix==2) = 1;
fprintf('graythresh:%f\n',jaccard_coefficient(Gt,logical(mix)));
