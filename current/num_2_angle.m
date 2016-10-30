function angles = num_2_angle(ids, nums)
%Converts a motor num to an angle
%NOTE: the numbers passed must be ordered the same as ids
for i = 1:length(ids)
    if (ids(i) == 3)
        angles(i) = round((nums(i) - 512)/(3.41));
    elseif (ids(i) == 2) 
        angles(i) = round((nums(i) - 205) / (3.41));
    elseif (ids(i) == 1)
        angles(i) = round((nums(i) - 512) / (3.41));
    end
end
            