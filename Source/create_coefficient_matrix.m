function [A] = create_coefficient_matrix(points_x, points_y, spacing, dt, K)

grid_points = points_x*points_y;
A = sparse(grid_points);
y_points = 0;

for i = 1 : grid_points
    
    y_dist = y_points * spacing;
    L      = (y_dist-y_dist^2)/2 * dt/(2*spacing);
       
    A(i, i) = 1 + 4*K;
    
    % 1: Bottom left point, Dirichlet Neumann
    if    (i == 1)
           A(i, i+1)        = L - K;
           A(i, i+points_x) = -2*K;
                                 
    % 2: Bottom right point, Neumann Neumann    
    elseif (i == points_x)
        
           y_points = y_points + 1;
        
           A(i, i-1)        = -2*K;
           A(i, i+points_x) = -2*K;
                                         
    % 3: Top left point, Dirichlet Neumann        
    elseif (i == grid_points-points_x+1)   
           A(i, i+1)        = L - K;
           A(i, i-points_x) = -2*K;
                      
    % 4: Top right point, Neumann Neumann        
    elseif (i == grid_points)
           A(i, i-1)        = -2*K;
           A(i, i-points_x) = -2*K;
                   
    % 5: Left column, Dirichlet        
    elseif (mod(i, points_x) == 1) 
           A(i, i+1)        = L - K;
           A(i, i+points_x) = -K;
           A(i, i-points_x) = -K;
            
    % 6: Right column, Neumann      
    elseif (mod(i, points_x) == 0)
        
           y_points = y_points + 1;

           A(i, i-1)        = -2*K;
           A(i, i+points_x) = -K;
           A(i, i-points_x) = -K;
                      
    % 7: Bottom row, Neumann       
    elseif (i > 1 && i < points_x) 
           A(i, i+1)        = L - K;
           A(i, i-1)        = -(L + K);
           A(i, i+points_x) = -2*K;
                      
    % 8: Top row, Neumann       
    elseif (i > grid_points-points_x+1 && i < grid_points) 
           A(i, i+1)        = L - K;
           A(i, i-1)        = -(L + K);
           A(i, i-points_x) = -2*K;
                     
    % 9: Middle region, no boundary
    elseif (i > points_x && i < grid_points-points_x+1)
           A(i, i+1)        = L - K;
           A(i, i-1)        = -(L + K);
           A(i, i+points_x) = -K;
           A(i, i-points_x) = -K;     
    end    
    
end

end