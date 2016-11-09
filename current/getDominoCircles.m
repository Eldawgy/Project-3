function allCircleLocations = getDominoCircles(BW, bbox, colorIm)
%Returns a cell array containing the locations of circles on each domino.
%Each index of the cell array corresponds to a domino.

    %Find circles on each domino by examining cropped images of each
    %domino.
    for i = 1:length(bbox(:,1))
        dominoImage = imcrop(BW, bbox(i,:));
        circleLocations = imfindcircles(dominoImage, [3 8], ...
            'Sensitivity', 0.8, 'EdgeThreshold', 0.25, 'Method', 'twostage');
        %Convert center locations in cropped image to center locations in
        %uncropped image.
        for j = 1:length(circleLocations(:,1))
            if ~isempty(circleLocations)
                circleLocations(j,:) = (circleLocations(j,:)) + double(bbox(i,1:2));
            else
                circleLocations = [0,0];
            end
        end
        allCircleLocations{i} = circleLocations;
    end

   %View allCircleLocations in original colorIm.
   dominoValueImage = colorIm;
    for i = 1:length(bbox(:,1))
        dominoValueImage = insertMarker(dominoValueImage, allCircleLocations{i});
    end
      imshow(dominoValueImage);
        