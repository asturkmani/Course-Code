function [ CellOfImageSegments ] = im2segment( ImageToSegment )
%IM2SEGMENT This function takes as input an image of a string of characters
%and returns a stack of the character segments of the string.
% i.e. it segments the image into characters and stores each
%character in an index in CellOfImages
%   This is achieved by summing the contents of all the rows of the
%   binarized image and making the segmentation at the beginning of the 
%   positive numbers until the first 0 after the the sequence of non-zero 
%   numbers. This assumes that the value '0' represents white pixels and 
%   the value '1' represents black pixels.
CellOfImageSegments = cell(1,1);
%First we binarize the image and make white pixels = 0, black pixels = 1.
BinaryImage = ImageToSegment;
%We would like to flip the contents with high values becoming low values
%and vice-versa. 
BinaryImage(ImageToSegment < 120) = 0;
BinaryImage(ImageToSegment > 120) = 1;
BinaryImage = bwmorph(BinaryImage,'open');
% BinaryImage = bwmorph(BinaryImage,'close');
BinaryImage = ~BinaryImage;

%Next we sum all the rows mainting the columns
SummedColumns = sum(BinaryImage,1);

%Next we search for continous sequences of non-zero digits and mark those
%column indices.

%initialize start to 0.
start = 0;
%index of Cell
k=1;
for i=1:size(SummedColumns,2)
    %when we've found the beginning of a sequence
    if SummedColumns(i) ~= 0 && start == 0
        start = i;
    end
    %when we've found the end of the sequence
    if start~=0 && SummedColumns(i) == 0
        length = i-start;
        if length>5
        stop = i;
        %create white image
        PossibleSegment = zeros(size(BinaryImage));
        %copy segment
        PossibleSegment(:,start:stop) = BinaryImage(:,start:stop);
        %re-initialize
        
        %imagesc(PossibleSegment);
        CellOfImageSegments{k} = PossibleSegment;
        k=k+1;
        end
        start = 0;
    end
    end
    


end

