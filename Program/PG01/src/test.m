clear; clc; close all;

v_0 = @(x) sin(2*pi*x);
Tend = 0.3;

CFL_numbers = [0.5, 1.0, 1.5, 2.0];
J = 50;

figure;
for i = 1:length(CFL_numbers)
    CFL = CFL_numbers(i);
    dt = CFL / J;
    N = round(Tend / dt);
    
    v_num = solve_pde(N, J, Tend, v_0);
    v_exact_val = v_0(mod(linspace(0,1,J+1) + Tend, 1));
    
    subplot(2,ceil(length(CFL_numbers) / 2), i);
    plot(linspace(0,1,J+1), v_num, 'b--', 'DisplayName', 'Numerical');
    hold on;
    plot(linspace(0,1,J+1), v_exact_val, 'r-', 'DisplayName', 'Exact');
    title(sprintf('CFL = %.1f, J = %d', CFL, J));
    legend;
    
    err_inf = max(abs(v_num - v_exact_val));
    fprintf('CFL = %.1f, J = %d, err_inf = %.2e\n', CFL, J, err_inf);
end
