function colorVid = init_cam()
tic;
%Get videoinput (vi) object
colorVid = videoinput('kinect', 1, 'RGB_1280x960');

%Set input settings
colorVid.FramesPerTrigger = 1;  %Only request one frame per trigger call
colorVid.TriggerRepeat = Inf;   %Tell vi object to allow inf trigger calls

%% Set trigger config for vi object
triggerconfig(colorVid, 'manual');


%% Start vi device
start(colorVid);
