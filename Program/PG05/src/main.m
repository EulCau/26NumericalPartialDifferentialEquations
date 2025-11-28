clc; clear; close all;

% --- Problem Parameters ---
dx = 0.05;
J = round(1/dx); % J = 20 for grid 0 to 1
x = linspace(0, 1, J+1);

% Courant numbers to test
r_values = [0.2, 0.8]; 

% Times to capture
t_stops = [0.05, 0.2, 0.8, 3.2];

% Schemes to use
schemes = {'FTBS', 'FTCS', 'Lax-Wendroff'};

% Initial Condition Function u(x,0)
% Square wave between 0.4 and 0.6
v0_func = @(x) double(x >= 0.4 & x <= 0.6);

% --- Simulation Loop ---
for r_idx = 1:length(r_values)
    r = r_values(r_idx);
    dt = r * dx; % Calculate dt based on Courant number r = dt/dx
    
    % Create a figure for this Courant number
    figure('Name', sprintf('Results for r = %.1f', r), 'Color', 'w');
    sgtitle(sprintf('Advection u_t + u_x = 0 (r = %.1f, dx = %.2f)', r, dx));
    
    for t_idx = 1:length(t_stops)
        Tend = t_stops(t_idx);
        N = round(Tend / dt); % Number of time steps
        
        subplot(2, 2, t_idx);
        hold on; box on; grid on;
        
        % 1. Plot Exact Solution
        % Exact solution for u_t + u_x = 0 is u(x-t). 
        % Because the code uses periodic BCs on [0,1], we use mod.
        exact_v = v0_func(mod(x - Tend, 1)); 
        plot(x, exact_v, 'k-', 'LineWidth', 1.5, 'DisplayName', 'Exact');
        
        % 2. Calculate and Plot Numerical Solutions
        for s = 1:length(schemes)
            scheme_name = schemes{s};
            
            try
                % Call the provided solver
                v_num = solve_pde(N, J, Tend, v0_func, scheme_name);
                
                % Check for instability (blow-up)
                if any(isnan(v_num)) || max(abs(v_num)) > 5
                    fprintf('Scheme %s at t=%.2f (r=%.1f) unstable/omitted.\n', ...
                        scheme_name, Tend, r);
                    continue; 
                end
                
                % Plotting styles
                style = '';
                switch scheme_name
                    case 'FTBS'
                        style = 'b--o';
                    case 'FTCS'
                        style = 'r--x';
                    case 'Lax-Wendroff'
                        style = 'g--d';
                end
                
                plot(x, v_num, style, 'MarkerSize', 4, 'LineWidth', 1, ...
                     'DisplayName', scheme_name);
                 
            catch ME
                fprintf('Error running %s: %s\n', scheme_name, ME.message);
            end
        end
        
        % Formatting the Subplot
        title(sprintf('t = %.2f', Tend));
        xlabel('x'); ylabel('u');
        ylim([-0.2, 1.2]); % Keep y-axis consistent to see dissipation
        if t_idx == 1
            legend('Location', 'best');
        end
    end
end
