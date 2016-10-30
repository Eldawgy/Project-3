%SAME AS LAB 1 ONLY THE ARM LENGTHS HAVE CHANGED!!!!!
function thetas=invKin(point)
%calculates necessary angles for the arm to reach point (elbow up)
%TODO: add return values for exceptions (point at origin, point out of
%reach of arm) so that the robot will ignore points that it physically
%can't reach

l1 = 279;         %length of second link (called l1 to be consistent with solution given by surya; used in below calculations)
l2 = 348;         %length of third link " "
l3 = 122;   %was 97      %length of first link (height of base)

%off1 = 45;          %DISTANCE FROM ROTARY MOTOR TO A
off1 = 0;

px = point(1); %+ 16;
py = point(2); %CHANGED TO TRY TO ACCOUNT FOR OFFSET
pz = point(3); %- l3;


try
    assert(~isnan(py/px)); %check for case where we ae asking the robot to face the origin
    th0=atan(py /px);

catch
    disp('Cant face where Im standing, idiot');point
    return
end

    px = px - off1*cos(th0);
    py = py - off1*sin(th0);
    pxy = (px^2 + py^2)^.5;

th2 = acos((pxy^2+pz^2-l1^2-l2^2)/(2*l1*l2));  %2sols choose negative of angle and angle and plug ointo theta 1 sol to find both sols for theta 1.
try %check that the results are real (i.e. we haven't asked it to move somewhere it can't.
    if (th2 < 0)            %if its already elbow up flipped < to >
        cth1 = (pxy*(l1+l2*cos(th2))+pz*(l2*sin(th2)))/(l1^2+l2^2+2*l1*l2*cos(th2));
        sth1 = (-pxy*(l2*sin(th2))+pz*(l1+l2*cos(th2)))/(l1^2+l2^2+2*l1*l2*cos(th2));
        th1 = atan2(sth1, cth1);
        thetas=[th0 * (180/pi),th1 *(180/pi), th2*(180/pi)];
    else
        th2 = th2*-1;
        cth1 = (pxy*(l1+l2*cos(th2))+pz*(l2*sin(th2)))/(l1^2+l2^2+2*l1*l2*cos(th2));
        sth1 = (-pxy*(l2*sin(th2))+pz*(l1+l2*cos(th2)))/(l1^2+l2^2+2*l1*l2*cos(th2));
        th1 = atan2(sth1, cth1);
        thetas=[th0 * (180/pi), th1 * (180/pi), th2 *(180/pi)];
    end
catch
    msgID = 'IKINE:OOBM8';
    msg = 'I dont think I can reach this point (complex angles resultant from inverse kinematics';
    disp('X: ');point(1)
    disp('Y: ');point(2)
    disp('Z: ');point(3)
    baseException = MException(msgID,msg);
    throw(baseException);
end
end
 
