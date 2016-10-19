function [dominosInImage, bbox] = getDominosInImage(closedBW, colorIm)
%Given a BW and colorIM, this function returns an RGB image containing
%markers and bounding boxes, corresponding to the centroid and area of
%detected dominos

%First filter given BW image to only leave objects with the specified area
%and eccentricity.
%Min and max area parameters must be tuned depending on the height of
%camera relative to the domino.

cc = bwconncomp(closedBW); 
stats = regionprops(cc, 'Area','Eccentricity'); 
idx = find([stats.Area] > 1500 & [stats.Area] < 5000 & [stats.Eccentricity] > 0.8 &[stats.Eccentricity] < 0.9); 
cleansedBW = ismember(labelmatrix(cc), idx); 
%  imshow(cleansedBW);

blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', false, ...
    'MinimumBlobArea', 500);
bbox = step(blobAnalysis, cleansedBW);
dominosInImage = insertShape(colorIm, 'Rectangle', bbox, 'Color', 'green');
numDominos = size(bbox, 1);
dominosInImage = insertText(dominosInImage, [10 10], numDominos);

%calculate centroids and orienations of objects in post-processed BW image

centroid = regionprops(cleansedBW,'Centroid');
centroids = cat(1, centroid.Centroid);

stats2 = regionprops(cleansedBW, 'Orientation'); 

dominosInImage = insertMarker(dominosInImage, centroids);

for i = 1:length(centroids)
    dominosInImage = insertText(dominosInImage, centroids(i,:) + [30,0], num2str(stats2(i).Orientation));
end


