function cleanUp()
    %Unloads the libraries
    calllib('dynamixel','dxl_terminate');  
    unloadlibrary('dynamixel');
end