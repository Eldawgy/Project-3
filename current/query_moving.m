function motors = query_moving()
%Returns a list of all motor IDs that have reached the goal position
try
    P_Moving = 46;
    motors = [0,0,0];
    ids = [1,2,3];
    i = 0;
    
    for i = 1:length(ids(1,:))
        motors(ids(i)) = reg_read(ids(i), P_Moving);
    end
catch
    disp('ERR in query MOVING');
end