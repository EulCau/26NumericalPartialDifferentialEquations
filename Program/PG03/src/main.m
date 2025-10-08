clear; clc; close all;

v0 = @(x) sin(2*pi*x);
u_exact = @(x, t) sin(2*pi*(x + t));

fprintf('=== 问题1: 不同方法在时间演化中的表现 ===\n');

lambda = 0.5;
J = 80;
h = 1/J;
t_end_list = [0.1, 0.4, 0.8, 1.0];
schemes = {'FTCS', 'Lax-Friedrich', 'Lax-Wendroff'};
scheme_codes = {'B', 'D', 'E'};

for i = 1:length(t_end_list)
    t_end = t_end_list(i);
    dt = lambda * h;
    N = round(t_end / dt);

    for j = 1:length(schemes)
        v_num = solve_pde(N, J, t_end, v0, scheme_codes{j});
        x = linspace(0, 1, J+1);
        v_exact_val = u_exact(x, t_end);

        show_results(J, t_end, schemes{j}, v_num, v_exact_val, x);
    end
end

% ==================== 问题2 ====================
fprintf('\n=== 问题2: Lax-Wendroff方法在不同网格密度下的表现 ===\n');

lambda = 0.5;
t_end = 1.0;
J_list = [10, 20, 40, 80, 160];
method = 'Lax-Wendroff';
method_code = 'E';

for i = 1:length(J_list)
    J = J_list(i);
    h = 1/J;
    dt = lambda * h;
    N = round(t_end / dt);

    v_num = solve_pde(N, J, t_end, v0, method_code);
    x = linspace(0, 1, J+1);
    v_exact_val = u_exact(x, t_end);

    show_results(J, t_end, method, v_num, v_exact_val, x);
end
