% Title:   MATLAB CW2 - Heat Transfer
% Group:   30

% Q1: Draw temperature distribution.
simulate_2D_heat(2, 1, 0.02, 0.02, 0.05, [0 1 2 5 10]);

% Q2: Results sensitivity to grid resolution.
simulate_2D_heat(2, 1, 0.01, 0.02, 0.05, [0 1 2 5 10]);
simulate_2D_heat(2, 1, 0.1 , 0.02, 0.05, [0 1 2 5 10]);

% Q3: Results sensitivity to thermal diffusivity.
simulate_2D_heat(2, 1, 0.02, 0.02, 0.01, [0 1 2 5 10]);
