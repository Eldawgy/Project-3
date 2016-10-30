function move_2_angles(ids, angles)
    %Get the current position of the motors
    posNum = get_pos();
    %find the current angle of the motors
    currAngle = num_2_angle(ids, posNum);
    
    disp('Moving to angles'); angles(:)
    %Find the motornumbers of the angles given
    nextNums = angle_2_num(ids, angles);
    %move the motors to the motor numbers
    move_motors(ids, nextNums);
end
    
