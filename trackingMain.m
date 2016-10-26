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

for j = 1:length(bbox(:,1))
    points = detectMinEigenFeatures(rgb2gray(colorIm), 'ROI', bbox(j,:));
    tracker = vision.PointTracker('MaxBidirectionalError', 1);
    allPoints{j} = points;
    allTracker{j} = tracker;
    initialize(allTracker{j}, allPoints{j}.Location, colorIm);
end

for i = 1:30
    trigger(colorVid)
    frame = getdata(colorVid);
    out = frame;
    for k = 1:length(bbox(:,1))
       [points2, validity] = step(allTracker{k}, frame);
        out = insertMarker(out, points2(validity, :), '+');
    end
    imshow(out);
end

release(colorVid);

