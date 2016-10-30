function move_2_point(point)
%Moves the arm to the given point
motorAngles = invKin(point);
move_2_angles([1,2,3], motorAngles);

for i = 1:3
    wait_id(i);
end
pos = get_pos();
nums = angle_2_num([1,2,3], motorAngles);
message = sprintf('GOAL POS: %d,%d,%d\tACTUAL: %d,%d,%d\n', nums(1), nums(2),...
    nums(3), pos(1), pos(2), pos(3));
disp(message);
end
