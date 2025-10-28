clear; clc; close all;

v_0 = @(x) sin(2*pi*x);

%% 问题1: CTCS, λ = 0.5 和 1.5, J=80, t=1.0
Tend = 1.0; J = 80;
x = linspace(0,1,J+1);

for lambda = [0.5, 1.5]
    dt = lambda / J;  % 因 λ = dt/dx, dx = 1/J
    N = round(Tend / dt);
    v_num = solve_pde(N, J, Tend, v_0, 'CTCS');
    v_exact = sin(2*pi*(x + Tend));
    show_results(J, Tend, sprintf('CTCS(λ=%.1f)', lambda), v_num, v_exact, x);
end

%% 问题2: CTCS, λ = 0.5, J=10,20,40,80,160
lambda = 0.5; Tend = 1.0;
for J = [10, 20, 40, 80, 160]
    x = linspace(0,1,J+1);
    dt = lambda / J;
    N = round(Tend / dt);
    v_num = solve_pde(N, J, Tend, v_0, 'CTCS');
    v_exact = sin(2*pi*(x + Tend));
    show_results(J, Tend, 'CTCS(λ=0.5)', v_num, v_exact, x);
end

%% 问题3: FTBS, λ=0.5, J=80, t=0.2,0.5
lambda = 0.5; J = 80;
for Tend = [0.2, 0.5]
    x = linspace(0,1,J+1);
    dt = lambda / J;
    N = round(Tend / dt);
    v_num = solve_pde(N, J, Tend, v_0, 'FTBS');
    v_exact = sin(2*pi*(x + Tend));
    show_results(J, Tend, 'FTBS(λ=0.5)', v_num, v_exact, x);
end
