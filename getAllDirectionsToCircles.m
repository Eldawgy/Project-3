function allDirectionsToCircles = getAllDirectionsToCircles(centroids, circleLocations)
%Returns normal direction vectors from each dominos centroid to the 
%location of each circle on each domino.

    %Iterate over each domino.
    for i = 1:length(centroids)
        %Iterate over every circleLocation on each domino.
        for j = 1:length(circleLocations{i}(:,1))
            %If locations of circles on ith domino isnt [0, 0] (no circles)
            if all(circleLocations{i}(1,:))
                directionsToCircles(j,:) = circleLocations{i}(j,:) - centroids(i,:);
                %Normalize direction vectors
                normConstant = 1/norm(directionsToCircles(j,:));
                directionsToCircles(j,:) = normConstant*directionsToCircles(j,:);
            %If there are no circles on the ith domino
            else
                directionsToCircles(j,:) = [0,0];
            end
                allDirectionsToCircles{i}(j,:) = directionsToCircles(j,:);
        end
    end