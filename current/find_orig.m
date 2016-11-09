function [rotMat, transVec, framePoints] = find_orig(camMat, colorVid)
input('Place Central Frame');

rotMat = [];
num = 0;

%Try and calculate camera relative to central frame
while (1)
     try
        %Trigger a frame request
        trigger(colorVid)
        % Get the color frame RGB values
        colorIm = getdata(colorVid);
        [rotMat, transVec, framePoints] = detectCentralFrame(camMat, colorIm);

     catch
         disp('Central Frame not detected');
         num = num +1;
         if (num < 5)
             continue;
        end
     end
    ext = input('Happy with frame placement?');
     num = 0;
    if (ext)
        if (~isempty(rotMat))
            break
        end
    end
end