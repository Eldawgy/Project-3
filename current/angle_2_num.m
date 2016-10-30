function motorNums = angle_2_num(id, angles)
%Converts the angles to motor numbers, the ids and angles need to be
%ordered the same, ie, [id1, id2], [angleId1, angleId2]
motorNums = [];
for i = 1:length(id(1,:))
   if (id(i) == 3)
        motorNums(i) = round(512 + (3.41) * angles(i));
   elseif (id(i) == 2)
        motorNums(i) = round(205 + 3.41 * angles(i));
   elseif (id(i) == 1)
        motorNums(i) = round(512 + 3.41 * angles(i));
    end
end


    