function [T] = train()
%trains the classifier on OCRSegments.

load('ocrsegments.mat');
  
%
 
features = zeros(100,75);
for i=1:100
    featureV = segment2features(S{i});
    features(i,:) = featureV;
end

 %Training step
T = fitcknn(features,y','NumNeighbors',1);
save('classification_data', 'T');