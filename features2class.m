function [class] = features2class(featureVector, class_data)
%takes as input a feature vector and classifies it using a KNN classifier
class = predict(class_data, featureVector);
% class = classRF_predict(featureVector,class_data);
end

