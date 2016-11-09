ids = [1,2,3];

global ERRBIT_VOLTAGE
ERRBIT_VOLTAGE     = 1;
global ERRBIT_ANGLE 
ERRBIT_ANGLE       = 2;
global ERRBIT_OVERHEAT
ERRBIT_OVERHEAT    = 4;
global ERRBIT_RANGE
ERRBIT_RANGE       = 8;
global ERRBIT_CHECKSUM
ERRBIT_CHECKSUM    = 16;
global ERRBIT_OVERLOAD
ERRBIT_OVERLOAD    = 32;
global ERRBIT_INSTRUCTION
ERRBIT_INSTRUCTION = 64;

global COMM_TXSUCCESS
COMM_TXSUCCESS     = 0;
global COMM_RXSUCCESS
COMM_RXSUCCESS     = 1;
global COMM_TXFAIL
COMM_TXFAIL        = 2;
global COMM_RXFAIL
COMM_RXFAIL        = 3;
global COMM_TXERROR
COMM_TXERROR       = 4;
global COMM_RXWAITING
COMM_RXWAITING     = 5;
global COMM_RXTIMEOUT
COMM_RXTIMEOUT     = 6;
global COMM_RXCORRUPT
COMM_RXCORRUPT     = 7;

try
    delete(colorVid);
    clear colorVid;
catch
end

%Delete rotMat and transVec if they have a value from last execution
try
    delete(rotMat);
    delete(transVec);
catch
end

try
    initLib(port);
catch
    port = input('COM PORT?: ');
    initLib(port);
end
try
    speed = input('MOTOR SPEEDS?: ');
    set_speed(ids, speed);
catch
    set_speed(ids, [100, 100, 100]);
end

colorVid = init_cam();

cal = 0;
%prompt to see if camera calibration is neccessary
calib = input('Calibrate Camera?\n0 - no, 1 -yes: ');

if (calib)
    camMat = getIms(colorVid);
end

[rotMat, transVec, framePoints] = find_orig(camMat, colorVid);

while(1)
    try
        point = input('Point: ');
        domRelFrame = domRefCF(rotMat, transVec, point);
 
        printf('Position of point in central frame is X: %d Y: %d \n',...
             domRelFrame(1), domRelFrame(2)); 

        % Update data in image display objects
        %set(cim, 'cdata', J); %Color

        %drawnow;
        move_2_point(angles);
       % move_2_point(angles);
    catch
        continue;
    end
end
delete(colorVid);
clear colorVid;
cleanUp();