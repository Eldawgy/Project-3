function [labelledImage, bboxs, orientations, centroids] = getDominoLocations(BW, colorIm)
%Returns the location, orientation and bounding box parameters of each domino.
%Also return an image with these parameters labelled.

%First filter given BW image to leave only objects (dominos) with the 
%specified area(area of domino depends on distance to camera) and
%eccentricity.
cc = bwconncomp(BW); 
stats = regionprops(cc, 'Area','Eccentricity'); 
idx = find([stats.Area] > 1500 & [stats.Area] < 6000 & [stats.Eccentricity] > 0.78 &[stats.Eccentricity] < 0.92); 
cleansedBW = ismember(labelmatrix(cc), idx); 

%Create blobAnalysis object and detect bbox, centroid and orientation of 
%blobs in filtered BW image
blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', true, ...
    'OrientationOutputPort', true);
[centroids, bboxs, orientations] = step(blobAnalysis, cleansedBW);

%Label dominos by their bbox, centroid and orientation
labelledImage = insertShape(colorIm, 'Rectangle', bboxs, 'Color', 'green');
labelledImage = insertMarker(labelledImage, centroids);

for i = 1:length(centroids)
    labelledImage = insertText(labelledImage, centroids(i,:) + [50,20], num2str(orientations(i)));
end


