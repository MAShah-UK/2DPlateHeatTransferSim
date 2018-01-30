function b = create_load_vector(points_x, points_y, spacing, time, dt, K, prev_load)

grid_points = points_x*points_y;
b           = sparse(grid_points, 1);
D           = 0;
y_points    = 0;

for i = 1 : grid_points
  
    y_dist = y_points * spacing;
    L      = (y_dist-y_dist^2)/2 * dt/(2*spacing);
    
    if (time > 2) D = 0;
    else          D = 20*(L + K)*sin(pi()*time/2);
    end
                   
    b(i) = prev_load(i);
                            
    if     (mod(i, points_x) == 1)  
           b(i) = b(i) + D;
               
    elseif (mod(i, points_x) == 0)
           y_points = y_points + 1;
    end 
            
end

end