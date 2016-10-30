function set_speed(ids, speeds)
%Sets the motor speeds of the given ids to the speeds
%NOTE: speed must be ordered the same as ids
for i = 1:length(ids)
    reg_write(ids(i), 32, speeds(i));
end
end