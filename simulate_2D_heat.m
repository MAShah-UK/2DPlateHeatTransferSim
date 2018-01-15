% This function accepts five inputs and outputs plots of the simulated heat transfer
% at the requested save_times. 
%   Length, width and spacing are in metres.
%   dt and save_times are in seconds.
%   diffusivity is in m^2/s.

function [] = simulate_2D_heat(length, width, spacing, dt, diffusivity, save_times)

points_x = length/spacing - 1;  
points_y = width/spacing - 1;  
K = diffusivity*dt / spacing^2;
A = create_coefficient_matrix(points_x, points_y, spacing, dt, K);

b = sparse(points_x*points_y, 1);
x = sparse(points_x*points_y, 1);
time = 0;
max_time = max(save_times);
saved_plots = 0;

graph = surf([spacing : spacing : length - spacing], ...
             [spacing : spacing : width - spacing], reshape(x, points_x, points_y)');
title('Plate Temperature Profile');
xlabel('Length (m)');
ylabel('Width (m)');
zlabel('Temperature (K)');
xlim([0 length]);
ylim([0 width]);

while time <= max_time
    
    b = create_load_vector(points_x, points_y, spacing, time, dt, K, x);
    x = A\b;
      
    title(strcat('Plate Temperature Profile [', num2str(time), 's]'));
    set(graph, 'ZData', reshape(x, points_x, points_y)');
    drawnow
    
    for i = 1 : max(size(save_times))
        if abs(save_times(i) - time) < 0.001
           saved_plots = saved_plots + 1;
           saveas(graph, strcat('Graphs\#', num2str(saved_plots), ' at time [', num2str(time), 's].png'));
        end
    end
    
    time = time + dt;
end

end