function camMat = calibrate(colorVid)
cal = 0;
%prompt to see if camera calibration is neccessary
calib = input('Calibrate Camera?\n0 - no, 1 -yes: ');

if (calib)
    camMat = getIms(colorVid);
end