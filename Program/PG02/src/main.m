clear; clc; close all;

% 配置参数
Tend = 0.3;                 % 终止时间
dx = 0.002;                  % 空间步长
dt_values = [0.001, 0.003];   % 时间步长测试值

v_0 = @(x) sin(2*pi*x);
v_exact = @(x) sin(2*pi*(x+Tend));

% 计算网格点数
J = round(1/dx);

for i = 1:length(dt_values)
    dt = dt_values(i);
    N = round(Tend/dt);
    
    % 计算三种方案的数值解
    v_num_A = solve_pde(N, J, Tend, v_0, 'A');
    v_num_B = solve_pde(N, J, Tend, v_0, 'B');
    v_num_C = solve_pde(N, J, Tend, v_0, 'C');
    
    % 显示结果
    show_results(v_num_A, v_num_B, v_num_C, v_exact, ...
        sprintf('测试 %d: Δx = %.3f, Δt = %.3f', i, dx, dt));
end
