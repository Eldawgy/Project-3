function wait_id(id)
    %Waits for the motor passed by id to reach its goal position
    try
    P_Moving = 46;
    moving = reg_read(id, P_Moving);        %MAYEB READ BYTE INSTEAD OF WORD
    
    while(moving)
            moving = reg_read(id, P_Moving);
    end
    
    catch
        disp('ERR in waitId!');
    end
end