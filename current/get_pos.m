function pos = get_pos()
%Returns the present motor numbers
ids = [1,2,3];
for i = 1:length(ids)
    pos(i) = reg_read(ids(i), 36);
end