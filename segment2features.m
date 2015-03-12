function [x] = segment2features(B)

%clean the image and scale it to 32x32

B = cleanImage(B);

ymid=floor(size(B,1)/2);
xmid=floor(size(B,2)/2);

xmean=mean(B,1);
ymean=mean(B,2);

x=zeros(1,11);

t = sum(sum(B));
tup = sum(sum(B(1:ymid,:)));
tdown = sum(sum(B(ymid:size(B,1),:)));
tleft = sum(sum(B(:,1:xmid)));
tright = sum(sum(B(:,xmid:size(B,2))));
tcenterSquare = sum(sum(B(ymid-8:ymid+8,xmid-8:xmid+8)));
tYstrip = sum(sum(B(:,xmid-4:xmid+4)));
tXstrip = sum(sum(B(ymid-4:ymid+4,:)));


%taking ratios
x(1)= tup/t;
x(2)= tup/tdown;
x(3)= tup/tleft;
x(4)= tleft/tdown;
x(5)= tright/tdown; 
x(6)= tcenterSquare/(t-tcenterSquare);
x(7)= tYstrip/tXstrip; 
x(8)= tYstrip/t; 
x(9)= tXstrip/t;
x(10) = std(xmean);
x(11) = std(ymean);     
      
k=12;
% zoning:
for i=1:4:32
    for j=1:4:32
        x(k) = mean(mean(B(i:i+3,j:j+3)));
        k=k+1;
    end
end
      

end