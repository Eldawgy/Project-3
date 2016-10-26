try
    delete(colorVid)
    clear colorVid
catch
end
 
colorVid = videoinput('kinect', 1, 'RGB_1280x960');
colorVid.FramesPerTrigger = 1;
colorVid.TriggerRepeat = Inf;
triggerconfig(colorVid, 'manual');

start(colorVid);

for i = 1:10

    trigger(colorVid)
    colorIm = getdata(colorVid);
    gray = rgb2gray(colorIm);
    %Reduce noise in image and fill shapes for blob detection.
    BW = edge(gray, 'canny', 0.2);
    cleanBW = bwmorph(BW, 'clean');
    bridgeBW = bwmorph(cleanBW, 'bridge');
    thickBW = bwmorph(bridgeBW, 'thicken');
    filteredBW = bwareaopen(thickBW, 300);
    filledBW = imfill(filteredBW, 'holes');
    closedBW = imclose(filledBW, strel('disk', 10));
    %Get domino location parameters.
    [labelledImage, bbox, orientations, centroids] = getDominoLocations(closedBW, colorIm);
    %Get direction vectors along the major axis of each domino.
    dominoDirections = getDominoDirections(orientations);
    %Get locations of all circles on all dominos.
    allCircleLocations = getDominoCircles(BW, bbox, labelledImage);
    %Get direction vectors to each circle (from each domino centroid) for
    %each domino.
    allDirectionsToCircles = getAllDirectionsToCircles(centroids, allCircleLocations);
    %Get value of each domino.
    dominoValues = getDominoValues(dominoDirections, allDirectionsToCircles);
     
    %Label each domino with its value.
     for j = 1:length(centroids)
         labelledImage = insertText(labelledImage, centroids(j,:) - [50,20] , num2str(dominoValues(j,:)));
     end
    
    %Display each labelledImage.
    imshow(labelledImage);

end

delete(colorVid)
clear colorVid

