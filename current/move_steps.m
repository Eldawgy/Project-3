function move_steps(start, endPoint, num)

for i = 1:num
    currentPoint(1) = i*(endPoint(1) - start(1))/num + start(1);
    currentPoint(2) = i*(endPoint(2) - start(2))/num + start(2);
    currentPoint(3) = i*(endPoint(3) - start(3))/num + start(3);
    move_2_point(currentPoint);
end
