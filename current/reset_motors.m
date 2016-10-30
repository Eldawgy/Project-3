function reset_motors
%Resets the motors to a vertical position
%NOTE: would be the same as move_motors([1,2,3], [0,90,0])
ids = [1,2,3];

move_motors(ids, [512, 512, 512]);
end