function read = reg_read(id, reg)
%Reads the high and low bytes in the register of the given id
    read = int32(calllib('dynamixel', 'dxl_read_word', id, reg));

    printErrorCode();
    comms = int32(calllib('dynamixel', 'dxl_get_result'));
    if comms ~= 1
        printCommStatus(comms);
    end
end