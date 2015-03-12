function [ CleanImage] = cleanImage( InputImage )
% cuts away excess white around the character, allowing 4 columns of
%   whitespace to the left and right of the image and everything above and
%   below after centering the image. In short, cleans the image.

    indicesOfNonZeroC = find(sum(InputImage));
    indicesOfNonZeroR = find(sum(InputImage,2));
    
    centerInputy = floor(mean(indicesOfNonZeroR));
    centerInputx = floor(mean(indicesOfNonZeroC));
    
    xmin = min(indicesOfNonZeroC);
    xmax = max(indicesOfNonZeroC);
    
    ymin = min(indicesOfNonZeroR);
    ymax = max(indicesOfNonZeroR);
    
    
    %place the image in a square frame
    width = xmax-xmin+1;
    height = ymax-ymin+1;
    
    longestEdge = max(width,height);
    
    CleanImage = zeros(longestEdge+2,longestEdge+2);
    centerCI = floor(longestEdge/2) + 1;
    aa = centerCI-floor(height/2)+1;
    e = mod(height,2);
    if e==0
        bb = centerCI+floor(height/2);
    else
        bb = centerCI+floor(height/2)+1;
    end
    cc = centerCI-floor(width/2)+1;
    e = mod(width,2);
    if e==0
        dd = centerCI+floor(width/2);
    else
        dd = centerCI+floor(width/2)+1;
    end
    
    if size(indicesOfNonZeroR,1)<(bb-aa+1)
        aa = -size(indicesOfNonZeroR,1)+1+bb;
    end
    if size(indicesOfNonZeroC,2)<(dd-cc+1)
        cc = -size(indicesOfNonZeroC,2)+1+dd;
    end
    CleanImage(aa:bb,cc:dd) = InputImage(indicesOfNonZeroR,indicesOfNonZeroC);
     %scale to 32x32.
     %note that scaling reduces the resultion/introduces noise into the
     %image.
    scale = 32/(longestEdge+2);
    CleanImage = round(imresize(CleanImage,scale));
    
    
    
    
   



end

