function move_motors(ids, goalPos)
%Takes a list of ids and goalPositions moves each motor id to goalPos
%NOTE: Positions are indexed in the same order as the ids
    P_Goal_Pos = 30; %lower byte
    for i = 1:length(ids(1,:))
        reg_write(ids(i), P_Goal_Pos, goalPos(i));
    end
end
