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
%         if Br(i,j) == 1 || Bg(i,j) == 1
%              if Bb(i,j) == 0
%                  if Br(i,j) == Bg(i,j)
%                     mix(i,j) = 1;
%                  else
%                     mix(i,j) = 2;
%                  end
%              end
%         end
        if Br(i,j) == 1 
            mix(i,j) = 0;
        end
        if Bg(i,j) == 1
            mix(i,j) = 1;
        end
        if Bb(i,j) == 1
            mix(i,j) = 2;
        end
        if Br(i,j) == 1 && Bg(i,j) == 1
            mix(i,j) = 3;
        end
        
    end
end

%This for LAB color
% for i=1:X
%     for j=1:Y
%         if Bb(i,j) == 1 && Bg(i,j) == 0 && Br(i,j) == 1
%              mix(i,j) = 1;
%         end
%     end
% end
%LAB color end
imshow(label2rgb(mix,map,[0,0,0]));
mix(mix==2) = 1;
mark1 = (jaccard_coefficient(logical(Gt==0),logical(mix==0)|logical(mix==2)));
mark2 = (jaccard_coefficient(logical(Gt==128),logical(mix==3)));
mark3 = (jaccard_coefficient(logical(Gt==255),logical(mix==1)));
mark = (mark1+mark2+mark3)/3;
fprintf('graythresh:%f\n',mark);
