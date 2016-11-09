function values = getDominoValues(dominoDirections, allDirectionsToCircles)
%Returns the values of each domino. Each Row of values corresponds to the
%value of a domino.

%Pre-allocate array size for speed
values = zeros(length(dominoDirections), 2);

%Iterate over each domino direction vector.
for i = 1:length(dominoDirections)
    %If there are circles on the ith domino. 
    if all(allDirectionsToCircles{i}(1,:))
        %Iterate over each circle location on the ith domino.
        for j = 1:length(allDirectionsToCircles{i}(:,1))
            %Calculate the dot product between the ith dominos direction vector
            %and the direction vector from the ith dominos centroid to the
            %jth circle location on that domino.
            dotProducts(j) = dominoDirections(i,1)*allDirectionsToCircles{i}(j,1) + ...
                dominoDirections(i,2)*allDirectionsToCircles{i}(j,2);
            %If the dot product is positive, then the circle lies on one
            %face. Threshold the dot product to exclude noisy circles
            %on the dominos centre line from value calculations.
            if dotProducts(j) > 0.15;
                values(i,1) = values(i,1) + 1;
            %If the dot product is negative, then the circle lies on the
            %other face.
            elseif dotProducts(j) < -0.15;
                values(i,2) = values(i,2) + 1;
            end
        end
    end
end

