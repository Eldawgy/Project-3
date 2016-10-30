function ret = initLib(DEFAULT_PORTNUM)
%initialises the library and connects via the COM port given
    loadlibrary('dynamixel','dynamixel.h');
    libfunctions('dynamixel'); 
    
    DEFAULT_BAUDNUM = 1; % 1mbps

    res = calllib('dynamixel','dxl_initialize',DEFAULT_PORTNUM,DEFAULT_BAUDNUM);
    if res == 1
        disp('Succeed to open USB2Dynamixel!');
        ret = 0;
    else 
        disp('Failed to open USB2Dynamixel!');
        cleanUp();
        ret = 1;
    end
    %Sets the speeds to 100(~10% Max rpm) for each motor
    set_speed([1,2,3], [100,100,100]);
end

