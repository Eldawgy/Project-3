function reg_write(id, reg, val);
%writes val to the high and low bytes of the register given for the id
    calllib('dynamixel', 'dxl_write_word', id, reg, val);
    printErrorCode();
    comms = int32(calllib('dynamixel', 'dxl_get_result'));
    if comms ~= 1
        printCommStatus(comms);
    end
end