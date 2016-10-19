function [dominoValueImage, allCenters] = getDominoValues(BW, bbox, colorIm)
    for i = 1:length(bbox)
        %crop corners of domino for circle detection
        bbox(i,1) = bbox(i,1) + bbox(i,3)/18;
        bbox(i,3) = bbox(i,3)*16/18;
        dominoImage = imcrop(BW, bbox(i,:));
        [centers, radii] = imfindcircles(dominoImage, [3 10], 'Sensitivity', 0.85, 'EdgeThreshold', 0.2);
        %Convert center locations in cropped image to center locations in
        %uncropped image
        if ~isempty(centers)
          for j = 1:length(centers(:,1))
                centers(j,:) = (centers(j,:)) + double(bbox(i,1:2));
          end
        else
            centers = [0,0];
        end
          allCenters{i} = centers;
        allRadii{i} = radii;
    end
   dominoValueImage = colorIm;
    for i = 1:length(bbox)
        dominoValueImage = insertMarker(dominoValueImage, allCenters{i});
    end
    imshow(dominoValueImage);
        