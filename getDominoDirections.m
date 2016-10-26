function dominoDirections = getDominoDirections(orientations)
%Returns an array of direction vectors along the major axis of each domino. 
%Each row of the array corresponds to a different directionVector.

    for i = 1:length(orientations)
        orientation = orientations(i);
        %Correct x-component of direction vector by multiplying by the sign of the angle.
        dominoDirections(i,:) = [sign(orientation)*cosd(orientation),sind(orientation)];
    end
    