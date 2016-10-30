function loads = query_loadings()
%Returns the present Load of each motor
try
ids = [1,2,3];
loads = [0,0,0];

P_Present_Load = 40 %Lowest byte of present load register
                    %need upper byte aswell for load direction

    for i = 1:length(ids(1,:))
        loads(ids(i)) = reg_read(ids(i), P_Present_Load); 
    end
    
catch
    disp('ERR in queryLoadings');
end
end
    